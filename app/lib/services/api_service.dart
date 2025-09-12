import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8001';
  
  static Future<http.Response> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    return response;
  }
  
  static Future<http.Response> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return response;
  }
  
  static Future<http.Response> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return response;
  }
  
  static Future<http.Response> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl$endpoint'));
    return response;
  }
}