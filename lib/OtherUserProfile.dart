import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class OtherUserProfile extends StatefulWidget {
  final String userID;

  OtherUserProfile({required this.userID});

  @override
  _OtherUserProfileState createState() => _OtherUserProfileState();
}


class _OtherUserProfileState extends State<OtherUserProfile> {
  final databaseReference = FirebaseDatabase.instance.ref();

  // User data variables
  String firstName = '';
  String lastName = '';
  String username = '';
  String bio = '';
  // Add other necessary user data variables

  @override
  void initState() {
    super.initState();
    print("OtherUserProfile initState for userID: ${widget.userID}");
    fetchUserData();
  }


  Future<void> fetchUserData() async {
    final userSnapshot = await databaseReference.child('Users/${widget.userID}').get();
    if (userSnapshot.exists) {
      // Ensure the snapshot value is not null and cast it safely to Map<String, dynamic>
      final userData = userSnapshot.value as Map<String, dynamic>?;
      if (userData != null) {  // Check if the casted userData is not null
        setState(() {
          firstName = userData['firstName'] ?? '';
          lastName = userData['lastName'] ?? '';
          username = userData['username'] ?? '';
          bio = userData['bio'] ?? '';
          // Set other user data state variables
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(username)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile UI components like profile picture, bio, etc.
          ],
        ),
      ),
    );
  }
}
