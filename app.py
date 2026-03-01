from flask import Flask, render_template, request, redirect
import sqlite3

app = Flask(__name__)

# เปลี่ยนชื่อ Database ตรงนี้
DATABASE = "first.db"


def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn


@app.route("/")
def index():
    conn = get_db_connection()
    students = conn.execute("SELECT * FROM students").fetchall()
    conn.close()
    return render_template("index.html", students=students)


@app.route("/add", methods=["POST"])
def add_student():
    name = request.form["name"]
    age = request.form["age"]

    conn = get_db_connection()
    conn.execute(
        "INSERT INTO students (name, age) VALUES (?, ?)",
        (name, age)
    )
    conn.commit()
    conn.close()

    return redirect("/")


if __name__ == "__main__":
    app.run(debug=True)