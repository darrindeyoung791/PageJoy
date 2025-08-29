import 'dart:convert';
import '../models/user.dart';
import 'api_service.dart';

class UserService {
  static Future<User> createUser(Map<String, dynamic> userData) async {
    final response = await ApiService.post('/users/', userData);
    
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  static Future<User> getUser(int userId) async {
    final response = await ApiService.get('/users/$userId');
    
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<List<User>> getUsers({int skip = 0, int limit = 100}) async {
    final response = await ApiService.get('/users/?skip=$skip&limit=$limit');
    
    if (response.statusCode == 200) {
      final List<dynamic> usersJson = json.decode(response.body);
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<User> updateUser(int userId, Map<String, dynamic> userData) async {
    final response = await ApiService.put('/users/$userId', userData);
    
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }

  static Future<void> deleteUser(int userId) async {
    final response = await ApiService.delete('/users/$userId');
    
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}