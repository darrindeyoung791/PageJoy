import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  // 主题设置
  ThemeMode themeMode;
  bool useDynamicColor;
  
  // 阅读设置
  bool enableOfflineMode;
  
  // UI设置
  double fontSizeScale;
  bool enableHapticFeedback;
  
  AppSettings({
    this.themeMode = ThemeMode.system,
    this.useDynamicColor = true,
    this.enableOfflineMode = false,
    this.fontSizeScale = 1.0,
    this.enableHapticFeedback = true,
  });

  // 将设置转换为JSON以保存
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
      'useDynamicColor': useDynamicColor,
      'enableOfflineMode': enableOfflineMode,
      'fontSizeScale': fontSizeScale,
      'enableHapticFeedback': enableHapticFeedback,
    };
  }

  // 从JSON创建设置以加载
  static AppSettings fromJson(Map<String, dynamic> json) {
    return AppSettings(
      themeMode: ThemeMode.values[json['themeMode'] ?? ThemeMode.system.index],
      useDynamicColor: json['useDynamicColor'] ?? true,
      enableOfflineMode: json['enableOfflineMode'] ?? false,
      fontSizeScale: (json['fontSizeScale']?.toDouble() ?? 1.0).clamp(0.8, 2.0),
      enableHapticFeedback: json['enableHapticFeedback'] ?? true,
    );
  }

  // 与另一个设置对象比较
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppSettings &&
        themeMode == other.themeMode &&
        useDynamicColor == other.useDynamicColor &&
        enableOfflineMode == other.enableOfflineMode &&
        fontSizeScale == other.fontSizeScale &&
        enableHapticFeedback == other.enableHapticFeedback;
  }

  @override
  int get hashCode {
    return Object.hash(
      themeMode,
      useDynamicColor,
      enableOfflineMode,
      fontSizeScale,
      enableHapticFeedback,
    );
  }
}