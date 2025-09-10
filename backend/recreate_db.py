import sqlite3
import os
import tempfile
import shutil

# Paths
original_db_path = "./pagejoy.db"
temp_dir = tempfile.mkdtemp()
temp_db_path = os.path.join(temp_dir, "pagejoy_temp.db")
new_db_path = "./pagejoy_new.db"

print(f"Temporary directory: {temp_dir}")

# 1. Connect to the original database and export data
print("1. Exporting data from original database...")
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
    print(f"   Exporting data from table: {table_name}")
    cursor_original.execute(f"SELECT * FROM {table_name};")
    rows = cursor_original.fetchall()
    cursor_original.execute(f"PRAGMA table_info({table_name});")
    columns = cursor_original.fetchall()
    data[table_name] = {
        'rows': rows,
        'columns': columns
    }

conn_original.close()

# 2. Create a new database with UTF-8 encoding and import schema
print("2. Creating new database with UTF-8 encoding...")
conn_new = sqlite3.connect(new_db_path)
cursor_new = conn_new.cursor()

# Set encoding (SQLite uses UTF-8 by default, but we'll make sure)
conn_new.execute("PRAGMA encoding = 'UTF-8';")

# Recreate schema in new database
print("3. Recreating schema in new database...")
conn_temp = sqlite3.connect(temp_db_path)
cursor_temp = conn_temp.cursor()

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
            print(f"   Executed: {statement[:50]}...")
        except Exception as e:
            print(f"   Failed to execute: {statement[:50]}... Error: {e}")

conn_new.commit()
conn_temp.close()

# 4. Import data into new database
print("4. Importing data into new database...")
for table_name, table_data in data.items():
    if table_data['rows']:
        print(f"   Importing data into table: {table_name}")
        # Create INSERT statement
        placeholders = ','.join(['?' for _ in table_data['rows'][0]])
        insert_sql = f"INSERT INTO {table_name} VALUES ({placeholders})"
        
        try:
            cursor_new.executemany(insert_sql, table_data['rows'])
        except Exception as e:
            print(f"   Failed to insert data into {table_name}. Error: {e}")

conn_new.commit()
conn_new.close()

# 5. Clean up temporary directory
print("5. Cleaning up...")
shutil.rmtree(temp_dir)

print(f"New database created at: {new_db_path}")
print("Please verify the new database and replace the old one if everything is correct.")
