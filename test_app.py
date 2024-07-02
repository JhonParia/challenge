
import pytest
import json
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_index(client):
    """Test para el endpoint principal."""
    response = client.get('/')
    assert response.status_code == 200
    assert b'API is working successfully!' in response.data

def test_books(client):
    """Test para el endpoint de libros."""
    response = client.get('/books')
    assert response.status_code == 200
    data = json.loads(response.data)
    assert isinstance(data, list)  # Verifica que la respuesta sea una lista
    assert len(data) > 0  # Verifica que la lista no esté vacía
    for book in data:
        assert 'id' in book
        assert 'title' in book
        assert 'description' in book