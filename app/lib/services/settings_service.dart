import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings.dart';

class SettingsService {
  static const String _settingsKey = 'app_settings';
  
  // 从 SharedPreferences 加载设置
  static Future<AppSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString(_settingsKey);
    
    if (settingsJson != null) {
      final Map<String, dynamic> json = 
          Map<String, dynamic>.from((jsonDecode(settingsJson) as Map));
      return AppSettings.fromJson(json);
    }
    
    // 如果没有保存的设置，则返回默认设置
    return AppSettings();
  }
  
  // 保存设置到 SharedPreferences
  static Future<void> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = jsonEncode(settings.toJson());
    await prefs.setString(_settingsKey, settingsJson);
  }
  
  // API基础URL相关方法
  static Future<void> setApiBaseUrl(String baseUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiBaseUrl', baseUrl);
  }
  
  static Future<String> getApiBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('apiBaseUrl') ?? 'http://localhost:8001';
  }
}