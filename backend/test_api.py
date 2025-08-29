import requests
import json

BASE_URL = "http://localhost:8000"

def test_create_user():
    user_data = {
        "username": "testuser",
        "password": "testpassword",
        "email": "test@example.com"
    }
    response = requests.post(f"{BASE_URL}/users/", json=user_data)
    print("Create User Response:", response.status_code, response.json())
    return response.json()

def test_get_users():
    response = requests.get(f"{BASE_URL}/users/")
    print("Get Users Response:", response.status_code, response.json())

def test_create_article():
    article_data = {
        "title": "Test Article",
        "content": "This is a test article content.",
        "status": "published"
    }
    response = requests.post(f"{BASE_URL}/articles/", json=article_data)
    print("Create Article Response:", response.status_code, response.json())
    return response.json()

def test_get_articles():
    response = requests.get(f"{BASE_URL}/articles/")
    print("Get Articles Response:", response.status_code, response.json())

def test_health_check():
    response = requests.get(f"{BASE_URL}/health")
    print("Health Check Response:", response.status_code, response.json())

if __name__ == "__main__":
    print("Testing API endpoints...")
    test_health_check()
    test_create_user()
    test_get_users()
    test_create_article()
    test_get_articles()