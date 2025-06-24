from flask import Flask, jsonify
import psycopg2
from google.cloud import secretmanager

app = Flask(__name__)

def get_db_connection():
    client = secretmanager.SecretManagerServiceClient()
    secret_name = f"projects/{PROJECT_ID}/secrets/db-password/versions/latest"
    response = client.access_secret_version(name=secret_name)
    password = response.payload.data.decode("UTF-8")
    
    return psycopg2.connect(
        dbname="appdb",
        user="appuser",
        password=password,
        host="/cloudsql/<tu-project-id>:us-central1:cloudsql-instance"
    )

@app.route('/')
def index():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT NOW()")
    result = cur.fetchone()
    cur.close()
    conn.close()
    return jsonify({"time": str(result[0])})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)