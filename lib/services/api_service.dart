import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  static Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw Exception("Resource not found (404).");
      } else if (response.statusCode == 500) {
        throw Exception(
            "Server is currently down (500). Please try again later.");
      } else {
        throw Exception("Unexpected error occurred. Please try again.");
      }
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  static String _handleError(dynamic error) {
    if (error is http.ClientException) {
      return "Network error. Please check your internet connection.";
    } else if (error is FormatException) {
      return "Data format error. Unable to process the response.";
    } else {
      return "An unexpected error occurred. Please try again.";
    }
  }
}
