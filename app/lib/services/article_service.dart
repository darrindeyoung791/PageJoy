import 'dart:convert';
import '../models/article.dart';
import 'api_service.dart';

class ArticleService {
  static Future<Article> createArticle(Map<String, dynamic> articleData) async {
    final response = await ApiService.post('/articles/', articleData);
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create article');
    }
  }

  static Future<Article> getArticle(int articleId) async {
    final response = await ApiService.get('/articles/$articleId');
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load article');
    }
  }

  static Future<List<Article>> getArticles({int skip = 0, int limit = 100}) async {
    final response = await ApiService.get('/articles/?skip=$skip&limit=$limit');
    
    if (response.statusCode == 200) {
      final List<dynamic> articlesJson = json.decode(response.body);
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  static Future<Article> updateArticle(int articleId, Map<String, dynamic> articleData) async {
    final response = await ApiService.put('/articles/$articleId', articleData);
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update article');
    }
  }

  static Future<void> deleteArticle(int articleId) async {
    final response = await ApiService.delete('/articles/$articleId');
    
    if (response.statusCode != 200) {
      throw Exception('Failed to delete article');
    }
  }
}