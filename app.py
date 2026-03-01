from flask import Flask, render_template, jsonify
import oracledb

app = Flask(__name__)

# ==============================
# Oracle Connection
# ==============================
def get_connection():
    return oracledb.connect(
        user="UCENTER_USER",
        password="UCenterPassword123",
        dsn="oracle-db:1521/FREEPDB1"
    )

# ==============================
# Routes
# ==============================

@app.route("/")
def home():
    return render_template("index.html")


@app.route("/restaurants")
def show_restaurants():
    try:
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute("""
            SELECT RestaurantID, RestaurantName
            FROM Restaurant
        """)

        rows = cursor.fetchall()

        # แปลงเป็น JSON อ่านง่าย
        restaurants = []
        for row in rows:
            restaurants.append({
                "RestaurantID": row[0],
                "RestaurantName": row[1]
            })

        cursor.close()
        conn.close()

        return jsonify(restaurants)

    except Exception as e:
        return {"error": str(e)}


# ==============================
# Run App
# ==============================
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)