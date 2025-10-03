import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  Set<int> _favoriteArticleIds = <int>{};

  User? get user => _user;
  Set<int> get favoriteArticleIds => _favoriteArticleIds;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    _favoriteArticleIds.clear();
    notifyListeners();
  }

  void addFavoriteArticle(int articleId) {
    _favoriteArticleIds.add(articleId);
    notifyListeners();
  }

  void removeFavoriteArticle(int articleId) {
    _favoriteArticleIds.remove(articleId);
    notifyListeners();
  }

  bool isArticleFavorited(int articleId) {
    return _favoriteArticleIds.contains(articleId);
  }

  void setFavoriteArticles(List<int> articleIds) {
    _favoriteArticleIds = articleIds.toSet();
    notifyListeners();
  }
}