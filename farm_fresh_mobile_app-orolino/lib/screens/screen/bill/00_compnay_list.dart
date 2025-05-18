import 'package:book_store/config/palette.dart';
import 'package:book_store/screens/screen/bill/01_shop_wise_demand_charge.dart';
import 'package:flutter/material.dart';



class CompanyScreen extends StatefulWidget {
  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {


  final List<Map<String, dynamic>> companyIcons = [
    {'icon': Icons.golf_course_outlined, 'label': 'BOF Golf Club', 'route': ShopWiseDemandCharge()},
    // {'icon': Icons.business, 'label': 'Artillery Centre', 'route': null},
    // {'icon': Icons.shopping_bag, 'label': 'Company C', 'route': null},
    // {'icon': Icons.phone_android, 'label': 'Company D', 'route': null},
    // {'icon': Icons.build, 'label': 'Company E', 'route': null},
    // {'icon': Icons.public, 'label': 'Company F', 'route': null},
    // {'icon': Icons.security, 'label': 'Company G', 'route': null},
    // {'icon': Icons.devices, 'label': 'Company H', 'route': null},
    // {'icon': Icons.apartment, 'label': 'Company I', 'route': null},
    // {'icon': Icons.local_offer, 'label': 'Company J', 'route': null},
    // {'icon': Icons.lightbulb, 'label': 'Company K', 'route': null},
    // {'icon': Icons.credit_card, 'label': 'Company L', 'route': null},
    // {'icon': Icons.check_circle, 'label': 'Company M', 'route': null},
    // {'icon': Icons.language, 'label': 'Company N', 'route': null},
    // {'icon': Icons.analytics, 'label': 'Company O', 'route': null},
    // {'icon': Icons.account_balance, 'label': 'Company P', 'route': null},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu, color: Colors.black),
        title: Text(
          "Company Directory",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/user/mostafa2.jpeg"), // Replace with your image
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search company...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.tune, color: Colors.grey),
                ],
              ),
            ),
          ),

          // Grid of Company Icons
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: companyIcons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (companyIcons[index]['route'] != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => companyIcons[index]['route']),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            companyIcons[index]['icon'],
                            size: 30,
                            color: Color(0xFF2D4F52),
                          ),
                          SizedBox(height: 5),
                          Text(
                            companyIcons[index]['label'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF2D4F52),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
