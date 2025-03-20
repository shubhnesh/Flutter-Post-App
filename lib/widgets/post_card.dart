import 'package:flutter/material.dart';
import '../models/post.dart';
import '../screens/details_screen.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(post.id.toString(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(
          post.title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.blue),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsScreen(post: post)),
          );
        },
      ),
    );
  }
}
