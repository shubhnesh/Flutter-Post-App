import 'package:flutter/material.dart';
import '../models/post.dart';

class DetailsScreen extends StatelessWidget {
  final Post post;

  const DetailsScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Details")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Post ID", post.id.toString()),
                _buildDetailRow("User ID", post.userId.toString()),
                Divider(),
                Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                SizedBox(height: 10),
                Text(
                  post.body,
                  style: TextStyle(
                      fontSize: 16, color: Colors.grey[800], height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
