import sqlite3

DATABASE = "first.db"

conn = sqlite3.connect(DATABASE)

conn.execute("""
CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL
);
""")

conn.commit()
conn.close()

print("Database created successfully!")