import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> _posts = [];
  int _currentPage = 0;
  final int _limit = 35;
  bool _isLoading = false;
  bool _hasMoreData = true;
  String? _errorMessage;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null; // Reset error message
    });

    try {
      List<Post> newPosts = await ApiService.fetchPosts();
      if (newPosts.isNotEmpty) {
        setState(() {
          int startIndex = _currentPage * _limit;
          int endIndex = startIndex + _limit;
          if (endIndex > newPosts.length) endIndex = newPosts.length;

          _posts.addAll(newPosts.sublist(startIndex, endIndex));
          _currentPage++;
          if (_posts.length >= newPosts.length) {
            _hasMoreData = false;
          }
        });
      } else {
        setState(() {
          _hasMoreData = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString(); // Store the error message
      });
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
      _loadPosts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Posts",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: _errorMessage != null
          ? _buildErrorWidget() // Show error if exists
          : _buildPostList(),
    );
  }

  Widget _buildPostList() {
    return _posts.isEmpty && _isLoading
        ? Center(
            child: CircularProgressIndicator(
            color: Colors.red,
          ))
        : ListView.builder(
            controller: _scrollController,
            itemCount: _posts.length + (_hasMoreData ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _posts.length) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ));
              }
              return PostCard(post: _posts[index]);
            },
          );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 50),
          SizedBox(height: 10),
          Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _loadPosts,
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }
}
