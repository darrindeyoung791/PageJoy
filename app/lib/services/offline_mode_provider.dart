import 'package:flutter/material.dart';

class OfflineModeProvider with ChangeNotifier {
  bool _isOfflineMode = false;

  bool get isOfflineMode => _isOfflineMode;

  void setOfflineMode(bool value) {
    if (_isOfflineMode != value) {
      _isOfflineMode = value;
      notifyListeners();
    }
  }

  void toggleOfflineMode() {
    _isOfflineMode = !_isOfflineMode;
    notifyListeners();
  }
}