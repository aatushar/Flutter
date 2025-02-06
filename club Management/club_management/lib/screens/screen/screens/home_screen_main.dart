import 'package:flutter/material.dart';
import 'package:flutterzitproject/route/routes.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF5E6), // Light green background
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/md.jpg'), // Replace with actual image
                radius: 24,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello Syed Mostafa Jamal",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Welcome back, club",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.lightbulb_outline, color: Colors.black54),
              onPressed: () {
                // Handle light/dark mode toggle
              },
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            isScrollable: true,
            tabs: [
              Tab(text: "Top"),
              Tab(text: "Members"),
              Tab(text: "Tags"),
              Tab(text: "Filters"),
              Tab(text: "Categories"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(context),
            _buildTabContent(context),
            _buildTabContent(context),
            _buildTabContent(context),
            _buildTabContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1, // Square shape
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return _buildGridItem(context, item['image']!, item['title']!, item['subtitle']!, routeName: item['route']);
      },
    );
  }

// List of Menu Items
  final List<Map<String, String>> menuItems = [
    //{"image": "assets/md.jpg", "title": "Member Profile", "subtitle": "View profile", "route": AppRoutes.profile},
    {"image": "assets/calender.png", "title": "Calendar", "subtitle": "Contact Member", "route": AppRoutes.calender},
    {"image": "assets/derectory.png", "title": "Directory", "subtitle": "Member Directory", "route": AppRoutes.memberdirectory},
    {"image": "assets/search.png", "title": "Search", "subtitle": "Explore Members", "route": AppRoutes.filtermain},
    {"image": "assets/evn2.png", "title": "Events", "subtitle": "Club Updates", "route": AppRoutes.evn},
    // {"image": "assets/evn1.png", "title": "My Event", "subtitle": "Booking ", "route": AppRoutes.book},
    {"image": "assets/food.png", "title": "Food Order", "subtitle": "Track Orders", "route": AppRoutes.foodhome},
    {"image": "assets/2.png", "title": "Pay Due", "subtitle": "Track Orders", "route": AppRoutes.paydue},
    //{"image": "assets/6.png", "title": "Setting", "subtitle": "Track Orders", "route": AppRoutes.setting},
  ];

  Widget _buildGridItem(BuildContext context, String imagePath, String title, String subtitle, {String? routeName}) {
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
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 2),
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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
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
