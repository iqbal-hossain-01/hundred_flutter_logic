import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';
  //String paginationUrl = 'https://jsonplaceholder.typicode.com/posts?_page=1&_limit=10';
  final String page = '?_page';
  final String limit = '&_limit';
  // Get
  Future<List<dynamic>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  // Post
  Future<Map<String, dynamic>> createPost(String title, String body,
      [dynamic userId]) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  // Put
  Future<Map<String, dynamic>> updatePost(int id, String title, String body) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': title, 'body': body, 'userId': id})
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  // Delete
  Future<void> deletePost(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/posts/$id'));
      if (response.statusCode == 200) {
        print('Post deleted successful');
      } else {
        throw Exception('Failed to delete post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  // Pagination
  Future<List<dynamic>> fetchPaginationPost(int p, int l) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts$page=p$limit=l'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch Pagination post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
