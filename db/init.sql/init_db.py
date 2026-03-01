import oracledb
import time

# รอ DB container พร้อมก่อน (กัน connect เร็วเกินไป)
time.sleep(10)

connection = oracledb.connect(
    user="system",
    password="oracle",
    dsn="oracle-db:1521/XEPDB1"
)

cursor = connection.cursor()

with open("db/init.sql", "r") as f:
    sql_script = f.read()

for statement in sql_script.split(";"):
    if statement.strip():
        try:
            cursor.execute(statement)
        except Exception as e:
            print("Skipped:", e)

connection.commit()
cursor.close()
connection.close()

print("Database initialized!")