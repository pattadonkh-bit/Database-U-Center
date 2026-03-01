from flask import Flask, render_template, jsonify
import oracledb

app = Flask(__name__)

# =========================
# Oracle Connection
# =========================
def get_connection():
    return oracledb.connect(
        user="UCENTER_USER",
        password="UCenterPassword123",
        dsn="oracle-db:1521/FREEPDB1"
    )

# =========================
# Routes
# =========================

@app.route("/")
def home():
    return render_template("index.html")


# ดึงร้านอาหารทั้งหมด
@app.route("/restaurants")
def get_restaurants():
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT RestaurantID, RestaurantName
        FROM Restaurant
        ORDER BY RestaurantID
    """)

    rows = cursor.fetchall()

    data = []
    for r in rows:
        data.append({
            "id": r[0],
            "name": r[1]
        })

    cursor.close()
    conn.close()

    return jsonify(data)


# ดึงเมนูตามร้าน
@app.route("/menus/<int:restaurant_id>")
def get_menus(restaurant_id):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT MenuID, MenuName, Price, Description
        FROM Menu
        WHERE RestaurantID = :rid
        ORDER BY MenuID
    """, {"rid": restaurant_id})

    rows = cursor.fetchall()

    data = []
    for r in rows:
        data.append({
            "id": r[0],
            "name": r[1],
            "price": float(r[2]),
            "desc": r[3]
        })

    cursor.close()
    conn.close()

    return jsonify(data)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)