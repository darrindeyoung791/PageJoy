import sqlite3
import os
import tempfile
import shutil
import re

# Paths
original_db_path = "./pagejoy.db"
new_db_path = "./pagejoy_fixed.db"

print("开始修复数据库编码问题...")

# 1. Connect to the original database and export data
print("1. 从原始数据库导出数据...")
conn_original = sqlite3.connect(original_db_path)
cursor_original = conn_original.cursor()

# Get all table names
cursor_original.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = cursor_original.fetchall()

# Dictionary to store data
data = {}

# Export data from each table
for table in tables:
    table_name = table[0]
    if table_name == 'sqlite_sequence':  # Skip sqlite internal table
        continue
    print(f"   正在导出表: {table_name}")
    cursor_original.execute(f"SELECT * FROM {table_name};")
    rows = cursor_original.fetchall()
    cursor_original.execute(f"PRAGMA table_info({table_name});")
    columns = cursor_original.fetchall()
    data[table_name] = {
        'rows': rows,
        'columns': columns
    }

conn_original.close()

# 2. Create a new database with UTF-8 encoding
print("2. 创建使用UTF-8编码的新数据库...")
conn_new = sqlite3.connect(new_db_path)
cursor_new = conn_new.cursor()

# Set encoding (SQLite uses UTF-8 by default, but we'll make sure)
conn_new.execute("PRAGMA encoding = 'UTF-8';")

# 3. Recreate schema in new database
print("3. 在新数据库中重新创建表结构...")
# Get schema from original database using sqlite3 dump
schema_lines = []
with os.popen(f'sqlite3 "{original_db_path}" .schema') as dump_pipe:
    schema_dump = dump_pipe.read()

# Split schema into individual statements
schema_statements = schema_dump.split(';')

for statement in schema_statements:
    statement = statement.strip()
    if statement and not statement.startswith('sqlite_sequence'):
        # Replace CREATE TABLE with CREATE TABLE IF NOT EXISTS for safety
        if statement.startswith('CREATE TABLE'):
            statement = statement.replace('CREATE TABLE', 'CREATE TABLE IF NOT EXISTS', 1)
        try:
            cursor_new.execute(statement)
            print(f"   执行: {statement[:50]}...")
        except Exception as e:
            print(f"   执行失败: {statement[:50]}... 错误: {e}")

conn_new.commit()

# 4. Import data into new database
print("4. 将数据导入新数据库...")
for table_name, table_data in data.items():
    if table_data['rows']:
        print(f"   正在导入数据到表: {table_name}")
        # Create INSERT statement
        placeholders = ','.join(['?' for _ in table_data['rows'][0]])
        insert_sql = f"INSERT INTO {table_name} VALUES ({placeholders})"
        
        try:
            cursor_new.executemany(insert_sql, table_data['rows'])
        except Exception as e:
            print(f"   导入数据到 {table_name} 失败. 错误: {e}")

conn_new.commit()
conn_new.close()

print(f"新数据库创建完成: {new_db_path}")
print("请验证新数据库并替换旧数据库（如果一切正常）。")
