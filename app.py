import os
from flask import Flask, jsonify
from google.cloud import bigquery

app = Flask(__name__)

# Configura esta variable con tu archivo de credenciales JSON de Google Cloud
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "latamSA.json"
client = bigquery.Client()

# Define el nombre de tu proyecto, dataset y tabla
project_id = 'latam-challenge-427922'
dataset_id = 'latam_dataset'
table_id = 'mi_tabla'
table_ref = f"{project_id}.{dataset_id}.{table_id}"


def get_books():
    query = f"""
    SELECT id, title, description FROM `{table_ref}`
    """
    query_job = client.query(query)
    results = query_job.result()  # Espera hasta que la consulta termine

    books = []
    for row in results:
        books.append({
            "id": row["id"],
            "title": row["title"],
            "description": row["description"]
        })
    return books


@app.route('/books', methods=['GET'])
def list_books():
    books = get_books()
    return jsonify(books), 200


@app.route('/', methods=['GET'])
def index():
    return jsonify({'message': 'API is working successfully!'})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
