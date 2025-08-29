import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  group('API Tests', () {
    final baseUrl = 'http://localhost:8000';

    test('Health check endpoint', () async {
      final response = await http.get(Uri.parse('$baseUrl/health'));
      expect(response.statusCode, 200);
      final data = json.decode(response.body);
      expect(data['status'], 'ok');
    });

    test('Create and get user', () async {
      // Create a user
      final userResponse = await http.post(
        Uri.parse('$baseUrl/users/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': 'testuser',
          'password': 'testpassword',
          'email': 'test@example.com'
        }),
      );
      expect(userResponse.statusCode, 200);
      final userData = json.decode(userResponse.body);
      final userId = userData['id'];
      expect(userId, isNotNull);

      // Get the user
      final getResponse = await http.get(Uri.parse('$baseUrl/users/$userId'));
      expect(getResponse.statusCode, 200);
      final getUserData = json.decode(getResponse.body);
      expect(getUserData['username'], 'testuser');
    });

    test('Create and get article', () async {
      // Create an article
      final articleResponse = await http.post(
        Uri.parse('$baseUrl/articles/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': 'Test Article',
          'content': 'This is a test article.',
          'status': 'published'
        }),
      );
      expect(articleResponse.statusCode, 200);
      final articleData = json.decode(articleResponse.body);
      final articleId = articleData['id'];
      expect(articleId, isNotNull);

      // Get the article
      final getResponse = await http.get(Uri.parse('$baseUrl/articles/$articleId'));
      expect(getResponse.statusCode, 200);
      final getArticleData = json.decode(getResponse.body);
      expect(getArticleData['title'], 'Test Article');
    });
  });
}