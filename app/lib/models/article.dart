import 'dart:convert';
import '../services/api_service.dart';

class Article {
  final int id;
  final String title;
  final String content;
  final String status;
  final bool isPremium;
  final double? price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int viewCount;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.isPremium,
    this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.viewCount,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      status: json['status'],
      isPremium: json['is_premium'],
      price: json['price']?.toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      viewCount: json['view_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'status': status,
      'is_premium': isPremium,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'view_count': viewCount,
    };
  }
}

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