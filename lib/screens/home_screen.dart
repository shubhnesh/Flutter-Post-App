import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> _posts = []; // Stores loaded posts
  int _currentPage = 0; // Track current page (0-based index)
  final int _limit = 35; // Number of posts per load
  bool _isLoading = false; // Show loading indicator
  bool _hasMoreData = true; // Stop when all data is loaded
  late ScrollController _scrollController; // Track scrolling position

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _loadPosts(); // Load first batch
  }

  Future<void> _loadPosts() async {
    if (_isLoading || !_hasMoreData) return; // Prevent duplicate calls

    setState(() {
      _isLoading = true;
    });

    try {
      List<Post> newPosts = await ApiService.fetchPosts();
      if (newPosts.isNotEmpty) {
        setState(() {
          int startIndex = _currentPage * _limit;
          int endIndex = startIndex + _limit;
          if (endIndex > newPosts.length) endIndex = newPosts.length;

          _posts.addAll(
              newPosts.sublist(startIndex, endIndex)); // Load next batch
          _currentPage++; // Move to next batch
          if (_posts.length >= newPosts.length) {
            _hasMoreData = false; // Stop loading when all data is loaded
          }
        });
      } else {
        setState(() {
          _hasMoreData = false;
        });
      }
    } catch (e) {
      print("Error loading posts: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        _hasMoreData) {
      _loadPosts(); // Load more when near bottom
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: _posts.isEmpty && _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            )) // Show full-screen loader if no data
          : ListView.builder(
              controller: _scrollController,
              itemCount: _posts.length +
                  (_hasMoreData ? 1 : 0), // Add extra space for loader
              itemBuilder: (context, index) {
                if (index == _posts.length) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ), // Show loader at bottom
                  ));
                }
                return PostCard(post: _posts[index]);
              },
            ),
    );
  }
}
