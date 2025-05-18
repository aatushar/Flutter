import 'package:book_store/providers/auth_provider.dart';
import 'package:book_store/screens/screen/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_member_screen.dart';
import 'calendar_screen.dart';
import 'filter_main_screen.dart';
import 'filter_screen.dart';
import 'home_screen_main.dart';
import 'member_profile_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MemberSearchScreen(),
    AddMemberScreen(),
    MemberProfileScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = Provider.of<AuthProvider>(context).userEmail;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("ClubApp"),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.logout),
      //       onPressed: () {
      //         Provider.of<AuthProvider>(context, listen: false).logout();
      //         Navigator.pushReplacementNamed(context, '/');
      //       },
      //     ),
      //   ],
      // ),
      body: _pages[_selectedIndex], // Dynamic Page Rendering

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
            label: "Add",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Calendar", ),

          BottomNavigationBarItem( icon: Icon(Icons.settings),label: "Profile",),
        ],

      ),
    );
  }
}

// // Home Page Content
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final userEmail = Provider.of<AuthProvider>(context).userEmail;
//     return Center(
//       child: Text("Welcome, $userEmail!", style: TextStyle(fontSize: 20)),
//     );
//   }
// }
