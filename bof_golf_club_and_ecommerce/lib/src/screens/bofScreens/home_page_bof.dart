
import 'package:book_store/src/core/routes/routes.dart';
import 'package:book_store/src/screens/bofScreens/add_member_screen.dart';
import 'package:book_store/src/screens/bofScreens/filter_main_screen.dart';
import 'package:book_store/src/screens/bofScreens/member_profile_screen.dart';
import 'package:book_store/src/screens/bofScreens/setting_screen.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePageBof extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF5E6),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          automaticallyImplyLeading: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/md.jpg'),
                radius: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Syed Mostafa Jamal",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Welcome back, club",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.lightbulb_outline, color: Colors.black54),
              onPressed: () {},
            ),
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter, // ✅ Align content to the top
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: _buildTabContent(context),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                color: const Color(0xFF1A572B),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePageBof()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MemberSearchScreen()),
                  );
                },
              ),
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.grey),
                  onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMemberScreen()),
                  );},
                ),
              ),
              IconButton(
                icon: const Icon(Icons.person),
                color: Colors.grey,
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MemberProfileScreen()),
                );},
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.grey,
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen()),
                );},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shrinkWrap: true,
      // ✅ Prevent full scroll height
      physics: const NeverScrollableScrollPhysics(),
      // ✅ Optional: Disable scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return _buildGridItem(
          context,
          item['image']!,
          item['title']!,
          item['subtitle']!,
          routeName: item['route'],
        );
      },
    );
  }

  final List<Map<String, String>> menuItems = [
    {
      "image": "assets/calender.png",
      "title": "Calendar",
      "subtitle": "Contact Member",
      "route": RouteGenerator.calender
    },
    {
      "image": "assets/derectory.png",
      "title": "Directory",
      "subtitle": "Member Directory",
      "route": RouteGenerator.memberdirectory
    },
    {
      "image": "assets/evn2.png",
      "title": "Events",
      "subtitle": "Club Updates",
      "route": RouteGenerator.evn
    },
    {
      "image": "assets/food.png",
      "title": "Food Order",
      "subtitle": "Track Orders",
      "route": RouteGenerator.dashboard
    },
    {
      "image": "assets/2.png",
      "title": "Pay Due",
      "subtitle": "Track Orders",
      "route": RouteGenerator.paydue
    },
  ];

  Widget _buildGridItem(
    BuildContext context,
    String imagePath,
    String title,
    String subtitle, {
    String? routeName,
  }) {
    return GestureDetector(
      onTap: () {
        if (routeName != null) {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 30,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
