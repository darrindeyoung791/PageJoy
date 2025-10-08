import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'settings_service.dart';

class OfflineModeProvider with ChangeNotifier {
  bool _isOfflineMode = false;

  bool get isOfflineMode => _isOfflineMode;

  // 初始化时从保存的设置中加载离线模式状态
  OfflineModeProvider() {
    _initializeOfflineMode();
  }

  Future<void> _initializeOfflineMode() async {
    final settings = await SettingsService.loadSettings();
    _isOfflineMode = settings.enableOfflineMode;
    notifyListeners();
  }

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