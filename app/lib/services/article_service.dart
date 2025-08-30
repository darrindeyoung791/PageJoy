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
      'Flutter 3.0 Released with New Features',
      'Understanding Dart Null Safety',
      'Building Responsive UIs in Flutter',
      'State Management in Flutter: Provider vs Bloc',
      'Flutter Web: Tips and Tricks',
      'Creating Custom Animations in Flutter',
      'Testing Flutter Applications',
      'Flutter Performance Optimization',
      'Integrating Firebase with Flutter',
      'Building a Chat App with Flutter',
      'Flutter Navigation 2.0 Explained',
      'Theming in Flutter: Light and Dark Mode',
      'Flutter for Desktop: Getting Started',
      'Using SQLite in Flutter Apps',
      'Flutter vs React Native: A Comparison',
    ];
    
    final contents = [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor, nisl eget ultricies tincidunt, nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl. Nullam auctor, nisl eget ultricies tincidunt, nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit, nec luctus magna felis sollicitudin mauris.',
      'Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus.',
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
      throw Exception('Cannot create article in offline mode');
    }
    
    final response = await ApiService.post('/articles/', articleData);
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create article');
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
      throw Exception('Failed to load article');
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
      throw Exception('Failed to load articles');
    }
  }

  static Future<Article> updateArticle(int articleId, Map<String, dynamic> articleData) async {
    if (_isOffline) {
      throw Exception('Cannot update article in offline mode');
    }
    
    final response = await ApiService.put('/articles/$articleId', articleData);
    
    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update article');
    }
  }

  static Future<void> deleteArticle(int articleId) async {
    if (_isOffline) {
      throw Exception('Cannot delete article in offline mode');
    }
    
    final response = await ApiService.delete('/articles/$articleId');
    
    if (response.statusCode != 200) {
      throw Exception('Failed to delete article');
    }
  }
}