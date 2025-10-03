import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static String _baseUrl = 'http://localhost:8001';
  
  static String get baseUrl => _baseUrl;
  
  // Initialize the API service with saved settings
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _baseUrl = prefs.getString('apiBaseUrl') ?? 'http://localhost:8001';
  }
  
  // Set and save the base URL
  static Future<void> setBaseUrl(String url) async {
    _baseUrl = url;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiBaseUrl', url);
  }
  
  static Future<http.Response> get(String endpoint) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    
    // 尝试添加认证头（如果有令牌的话）
    final token = await _getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
    );
    return response;
  }
  
  static Future<http.Response> post(String endpoint, dynamic data) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    
    // 尝试添加认证头（如果有令牌的话）
    final token = await _getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
      body: json.encode(data),
    );
    return response;
  }
  
  static Future<http.Response> put(String endpoint, dynamic data) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    
    // 尝试添加认证头（如果有令牌的话）
    final token = await _getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    final response = await http.put(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
      body: json.encode(data),
    );
    return response;
  }
  
  static Future<http.Response> delete(String endpoint) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    
    // 尝试添加认证头（如果有令牌的话）
    final token = await _getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    final response = await http.delete(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
    );
    return response;
  }
  
  // 辅助方法：从SharedPreferences获取JWT令牌
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
}