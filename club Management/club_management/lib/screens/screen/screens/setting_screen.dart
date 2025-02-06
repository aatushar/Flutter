import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color(0xFFEFF8E9),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            MemberDetailsCard(),
            SizedBox(height: 16),
            SettingsOption(title: "Filter"),
            SettingsOption(title: "Notifications"),
            SettingsOption(title: "App Settings"),
            SettingsOption(title: "Help Center"),
            Spacer(),
            LogoutButton(),
            SizedBox(height: 16),
          ],
        ),
      ),
      //bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class MemberDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF3E5A66),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage("assets/md.jpg"), // Replace with actual image path
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Member Details",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Search Members",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;

  SettingsOption({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF3E5A66),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {},
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1F3B4D),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {},
        child: Text('Log out', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

// class CustomBottomNavigationBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       shape: CircularNotchedRectangle(),
//       notchMargin: 8.0,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(icon: Icon(Icons.home), onPressed: () {}),
//           IconButton(icon: Icon(Icons.search), onPressed: () {}),
//           SizedBox(width: 48), // Space for the floating action button
//           IconButton(icon: Icon(Icons.chat), onPressed: () {}),
//           IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
//         ],
//       ),
//     );
//   }
// }
