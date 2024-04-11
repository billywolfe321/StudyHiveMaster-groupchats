import 'package:flutter/material.dart';
import 'index.dart';
import 'Privacy.dart';
import 'AccountSettings.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching email

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffad32fe),
        title: GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
          child: Row(
            children: [
              Image.asset('assets/logo.png', width: 28),
              SizedBox(width: 28),
              Text("Study Hive", style: TextStyle(fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Forums"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: "Profile"),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => Forums()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
              break;
          }
        },
        backgroundColor: Color(0xffae32ff),
        elevation: 8,
        iconSize: 22,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSettingItem(title: "Account", icon: Icons.person, onTap: () => navigateToPage(context, AccountSettings())),
            buildSettingItem(title: "Privacy", icon: Icons.lock, onTap: () => navigateToPage(context, PrivacySettings())),
            buildSettingItem(title: "Report Bug", icon: Icons.bug_report, onTap: () => _reportBug(context)),
            SizedBox(height: 100),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => navigateToPage(context, Login()), // Adjust to correctly handle logout
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFEF2828), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0), side: BorderSide(color: Color(0xff808080), width: 1)), padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                child: Text("Log Out", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingItem({required String title, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(tileColor: Colors.transparent, title: Text(title, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black)), leading: Icon(icon, color: Color(0xff3a57e8), size: 24), trailing: Icon(Icons.arrow_forward_ios, color: Color(0xff808080), size: 18)),
    );
  }

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _reportBug(BuildContext context) {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: 'up2060620@myport.ac.uk', query: 'subject=Bug Report&body=Description of the bug:');
    launch(emailLaunchUri.toString());
  }
}
