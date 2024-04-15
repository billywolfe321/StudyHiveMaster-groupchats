import 'package:flutter/material.dart';

class AddGroupChat extends StatefulWidget {
  @override
  _AddGroupChatState createState() => _AddGroupChatState();
}

class _AddGroupChatState extends State<AddGroupChat> {
  String selectedCategory = '';

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  ElevatedButton buildCategoryButton(String category) {
    return ElevatedButton(
      onPressed: () {
        selectCategory(category);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedCategory == category ? Colors.blue : null, // Use backgroundColor instead of primary
      ),
      child: Text(category),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Group Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Group Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: [
                buildCategoryButton('General'),
                buildCategoryButton('Technology'),
                buildCategoryButton('Science'),
                buildCategoryButton('Sports'),
                buildCategoryButton('Art'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Add Participants',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Implement functionality to add participants from friends list
              },
              child: Text('From Your Friends List'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement submit button functionality
              },
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}