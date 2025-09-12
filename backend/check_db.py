import sqlite3

# Connect to the database
conn = sqlite3.connect('pagejoy.db')
cursor = conn.cursor()

# Execute the query
cursor.execute('SELECT * FROM article LIMIT 3')
articles = cursor.fetchall()

# Print the results
print('Sample articles:')
for article in articles:
    print(article)

# Close the connection
conn.close()