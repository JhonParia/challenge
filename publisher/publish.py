import json, os
from google.cloud import pubsub_v1

# Crea el cliente de Pub/Sub
publisher = pubsub_v1.PublisherClient()
project_id = os.getenv('GOOGLE_CLOUD_PROJECT')
topic_name = f'projects/latam-challenge-427922/topics/bq-topic'

# Verifica si el tema existe y si no, créalo
try:
    publisher.get_topic(topic=topic_name)
except Exception as e:
    print(f"Topic does not exist, creating new topic: {topic_name}")
    publisher.create_topic(name=topic_name)

# Datos que quieres enviar
data = {
    'id': '123',
    'title': 'Ejemplo de Título',
    'description': 'Este es un mensaje de ejemplo con descripción.'
}

# Serializa los datos a JSON
data_bytes = json.dumps(data).encode('utf-8')

# Publica el mensaje
future = publisher.publish(topic_name, data_bytes)
print(f"Message ID: {future.result()}")