import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;

  SearchScreen({required this.searchQuery});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  void searchDatabase(String query) async {
    // Implement your search logic here
    // For demonstration, let's assume we're searching for users by their username
    DatabaseReference ref = FirebaseDatabase.instance.ref('Users');
    DatabaseEvent event = await ref.orderByChild('username').equalTo(query).once();

    if (event.snapshot.value != null) {
      // Assuming the result is a list of users
      List<dynamic> users = [];
      event.snapshot.children.forEach((child) {
        users.add(child.value);
      });

      setState(() {
        _searchResults = users;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
          onChanged: searchDatabase,
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          var result = _searchResults[index];
          return ListTile(
            title: Text(result['username']),
            onTap: () {
              // Navigate based on the result type
              // For example, if it's a user, navigate to UserProfile.dart
            },
          );
        },
      ),
    );
  }
}
