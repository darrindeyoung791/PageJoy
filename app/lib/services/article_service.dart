import 'dart:convert';
import 'dart:math';
import '../models/article.dart';
import 'api_service.dart';

class ArticleService {
  // Flag to simulate offline mode
  static bool _isOffline = false;
  
  static void setOfflineMode(bool offline) {
    _isOffline = offline;
  }
  
  static bool isOffline() {
    return _isOffline;
  }

  // Generate sample articles for offline mode
  static List<Article> generateSampleArticles() {
    final titles = [
      'Flutter 3.0 发布新功能',
      '理解 Dart 空安全',
      '在 Flutter 中构建响应式 UI',
      'Flutter 状态管理：Provider vs Bloc',
      'Flutter Web：技巧和窍门',
      '在 Flutter 中创建自定义动画',
      '测试 Flutter 应用程序',
      'Flutter 性能优化',
      '将 Firebase 与 Flutter 集成',
      '使用 Flutter 构建聊天应用',
      'Flutter Navigation 2.0 详解',
      'Flutter 主题：浅色和深色模式',
      'Flutter 桌面开发入门',
      '在 Flutter 应用中使用 SQLite',
      'Flutter vs React Native 对比',
    ];
    
    final contents = [
      '这是示例文章的内容。这只是为了演示目的而创建的虚拟内容。在实际应用中，这些内容将从后端 API 获取。',
      '这是另一篇示例文章的内容。它展示了如何在 Flutter 应用中显示长文本内容，并处理文本溢出和多行显示。',
      '这是第三篇示例文章的内容。这些示例文章用于在离线模式下演示应用的功能，无需连接到实际的后端服务器。',
      '这是第四篇示例文章的内容。在实际应用中，这些文章将包含来自作者的真实内容，可能包括图片、视频和其他富媒体元素。',
      '这是第五篇示例文章的内容。这些示例文章帮助开发者在没有网络连接的情况下测试应用的 UI 和功能。',
    ];
    
    final random = Random();
    final articles = <Article>[];
    
    for (int i = 0; i < 20; i++) {
      articles.add(
        Article(
          id: i + 1,
          title: titles[random.nextInt(titles.length)],
          content: contents[random.nextInt(contents.length)],
          status: 'published',
          isPremium: random.nextBool(),
          price: random.nextBool() ? 9.99 : null,
          createdAt: DateTime.now().subtract(Duration(days: random.nextInt(30))),
          updatedAt: DateTime.now().subtract(Duration(hours: random.nextInt(24))),
          viewCount: random.nextInt(1000),
        ),
      );
    }
    
    return articles;
  }

  static Future<Article> createArticle(Map<String, dynamic> articleData) async {
    if (_isOffline) {
      throw Exception('离线模式下无法创建文章');
    }
    
    final response = await ApiService.post('/articles/', articleData);
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('创建文章失败');
    }
  }

  static Future<Article> getArticle(int articleId) async {
    if (_isOffline) {
      // In offline mode, return a sample article
      final sampleArticles = generateSampleArticles();
      return sampleArticles.firstWhere(
        (article) => article.id == articleId,
        orElse: () => sampleArticles[0],
      );
    }
    
    final response = await ApiService.get('/articles/$articleId');
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('加载文章失败');
    }
  }

  static Future<List<Article>> getArticles({int skip = 0, int limit = 100}) async {
    if (_isOffline) {
      // In offline mode, return sample articles
      await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
      final sampleArticles = generateSampleArticles();
      final endIndex = (skip + limit).clamp(0, sampleArticles.length);
      return sampleArticles.sublist(skip, endIndex);
    }
    
    final response = await ApiService.get('/articles/?skip=$skip&limit=$limit');
    
    if (response.statusCode == 200) {
      final List<dynamic> articlesJson = json.decode(response.body);
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('加载文章失败');
    }
  }

  static Future<Article> updateArticle(int articleId, Map<String, dynamic> articleData) async {
    if (_isOffline) {
      throw Exception('离线模式下无法更新文章');
    }
    
    final response = await ApiService.put('/articles/$articleId', articleData);
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('更新文章失败');
    }
  }

  static Future<void> deleteArticle(int articleId) async {
    if (_isOffline) {
      throw Exception('离线模式下无法删除文章');
    }
    
    final response = await ApiService.delete('/articles/$articleId');
    
    if (response.statusCode != 200) {
      throw Exception('删除文章失败');
    }
  }
}