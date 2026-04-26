from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
import json
from config import DB_CONFIG

app = Flask(__name__)
CORS(app)


def get_db():
    return mysql.connector.connect(**DB_CONFIG)


@app.route('/products', methods=['GET'])
def get_products():
    search = request.args.get('search', '').strip()
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    try:
        if search:
            cursor.execute("""
                SELECT *, (name LIKE %s) AS starts_with
                FROM products
                ORDER BY starts_with DESC, name ASC
            """, (search + '%',))
        else:
            cursor.execute("SELECT * FROM products ORDER BY created_at DESC")
        products = cursor.fetchall()
        return jsonify(products), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        conn.close()


@app.route('/products', methods=['POST'])
def add_product():
    data = request.get_json()
    required = ['name', 'description', 'price', 'image_url']
    missing = [f for f in required if not data.get(f)]
    if missing:
        return jsonify({'error': f'Missing fields: {", ".join(missing)}'}), 400
    try:
        price = float(data['price'])
        if price <= 0:
            return jsonify({'error': 'Price must be greater than zero'}), 400
    except (ValueError, TypeError):
        return jsonify({'error': 'Price must be a valid number'}), 400

    colors   = data.get('colors', '[]') or '[]'
    category = data.get('category', 'unisex').strip()

    conn = get_db()
    cursor = conn.cursor()
    try:
        cursor.execute("""
            INSERT INTO products (name, description, price, image_url, colors, category)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            data['name'].strip(),
            data['description'].strip(),
            price,
            data['image_url'].strip(),
            colors,
            category
        ))
        conn.commit()
        return jsonify({'message': 'Product added successfully', 'id': cursor.lastrowid}), 201
    except Exception as e:
        conn.rollback()
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        conn.close()


@app.route('/products/<int:product_id>', methods=['DELETE'])
def delete_product(product_id):
    conn = get_db()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM products WHERE id = %s", (product_id,))
        conn.commit()
        return jsonify({'message': 'Product deleted successfully'}), 200
    except Exception as e:
        conn.rollback()
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        conn.close()


@app.route('/products/<int:product_id>/colors', methods=['PUT'])
def update_colors(product_id):
    try:
        # Read raw body and parse manually — most reliable method
        raw = request.get_data(as_text=True)
        print(f"Raw body received: {raw}")

        data = json.loads(raw)
        colors = data.get('colors', '[]') or '[]'

        print(f"Updating product {product_id} with colors: {colors}")

        conn = get_db()
        cursor = conn.cursor()
        try:
            cursor.execute(
                "UPDATE products SET colors = %s WHERE id = %s",
                (colors, product_id)
            )
            conn.commit()
            print(f"Update successful, rows affected: {cursor.rowcount}")
            return jsonify({'message': 'Colors updated', 'id': product_id}), 200
        except Exception as e:
            conn.rollback()
            print(f"DB error: {e}")
            return jsonify({'error': str(e)}), 500
        finally:
            cursor.close()
            conn.close()

    except Exception as e:
        print(f"Request parsing error: {e}")
        return jsonify({'error': f'Could not parse request: {str(e)}'}), 400


if __name__ == '__main__':
    app.run(debug=True, port=5000)