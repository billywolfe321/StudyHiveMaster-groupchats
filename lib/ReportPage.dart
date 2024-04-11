import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  final String forumId;
  final String commentId; // Add this line

  ReportPage({required this.forumId, required this.commentId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: Center(
        child: Text('Report content goes here'),
        // Add your reporting form or functionality here
      ),
    );
  }
}

