// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/post.dart';

// class ApiService {
//   static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

//   static Future<List<Post>> fetchPosts() async {
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));

//       if (response.statusCode == 200) {
//         List jsonResponse = json.decode(response.body);
//         return jsonResponse.map((data) => Post.fromJson(data)).toList();
//       } else {
//         throw Exception("Failed to load posts");
//       }
//     } catch (error) {
//       throw Exception("Error fetching posts: $error");
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import 'dart:async';

class ApiService {
  static const String _baseUrl = "https://jsonplaceholder.typicode.com/posts";

  static Future<List<Post>> fetchPosts() async {
    await Future.delayed(Duration(seconds: 3)); // Adds a 3-second delay

    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}
