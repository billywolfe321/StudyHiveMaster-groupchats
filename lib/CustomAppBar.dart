import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'OtherUserProfile.dart'; // Ensure this import is correct

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<dynamic> _searchResults = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text.isNotEmpty) {
        _performSearch(_searchController.text);
      } else {
        setState(() => _searchResults.clear());
      }
    });
  }

  _performSearch(String query) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('Users');
    DatabaseEvent event = await ref.orderByChild('username')
        .startAt(query)
        .endAt('$query\uf8ff')
        .once();

    if (event.snapshot.exists) {
      List<dynamic> results = [];
      event.snapshot.children.forEach((child) {
        var val = Map<String, dynamic>.from(child.value as Map);
        val['key'] = child.key; // Store Firebase key or user ID
        results.add(val);
      });

      setState(() {
        _searchResults = results;
      });
    } else {
      setState(() {
        _searchResults = ['No results'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          elevation: 4,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffad32fe),
          title: !_isSearching
              ? GestureDetector(
            onTap: () => Navigator.of(context).pushReplacementNamed('/home'),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                Image.asset('assets/logo.png', width: 24),
                SizedBox(width: 8),
                Text("Study Hive", style: TextStyle(fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white)),
              ],
            ),
          )
              : TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            if (!_isSearching)
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                },
              ),
            if (_isSearching)
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                    _searchResults.clear();
                  });
                },
              ),
          ],
        ),
        if (_isSearching && _searchResults.isNotEmpty) _buildSearchResults(),
      ],
    );
  }

  Widget _buildSearchResults() {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints(maxHeight: 300),
      // Adjust the height as necessary
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _searchResults.length > 5 ? 5 : _searchResults.length,
        // Limit to 5 results
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) {
          var result = _searchResults[index];
          return ListTile(
            title: Text(result['username'] ?? 'No results'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtherUserProfile(userID: result['key']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}