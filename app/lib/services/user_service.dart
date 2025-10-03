import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserService {
  // 用户登录
  static Future<User> login(String username, String password) async {
    try {
      final response = await ApiService.post('/users/login', {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        final user = User.fromJson(userData);
        
        // 保存用户登录状态
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', user.id);
        await prefs.setString('username', user.username);
        
        return user;
      } else {
        throw Exception('登录失败: ${response.body}');
      }
    } catch (e) {
      throw Exception('登录失败: $e');
    }
  }

  // 用户注册
  static Future<User> register(String username, String password, {String? email}) async {
    try {
      final response = await ApiService.post('/users/', {
        'username': username,
        'password': password,
        'email': email,
      });

      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        return User.fromJson(userData);
      } else {
        throw Exception('注册失败: ${response.body}');
      }
    } catch (e) {
      throw Exception('注册失败: $e');
    }
  }

  // 检查用户是否已登录
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    return userId != null;
  }

  // 获取当前登录用户信息
  static Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final username = prefs.getString('username');
    
    if (userId != null && username != null) {
      // 这里应该调用API获取完整的用户信息
      try {
        final response = await ApiService.get('/users/$userId');
        if (response.statusCode == 200) {
          return User.fromJson(json.decode(response.body));
        }
      } catch (e) {
        print('获取用户信息失败: $e');
      }
    }
    return null;
  }

  // 登出
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('username');
    await prefs.remove('access_token'); // 移除JWT令牌
  }
}