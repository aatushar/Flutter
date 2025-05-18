import 'package:book_store/config/palette.dart';
import 'package:book_store/screens/screen/bill/02_bill_account.dart';
import 'package:book_store/screens/screen/screens/home_screen_main.dart';
import 'package:flutter/material.dart';


class ShopWiseDemandCharge extends StatefulWidget {
  @override
  _ShopWiseDemandChargeState createState() => _ShopWiseDemandChargeState();
}

class _ShopWiseDemandChargeState extends State<ShopWiseDemandCharge> {
  int _selectedIndex = 0; // Tracks the selected index

  final List<Map<String, dynamic>> charges = [
    {
      'icon': Icons.apartment,
      'label': 'Club Bill',
      'route': ElectricityBillAccount(),
    },    {'icon': Icons.water, 'label': 'Others Bill'},
    {'icon': Icons.security, 'label': 'Others Bill'},
    {'icon': Icons.account_balance, 'label': 'Others Bill'},
    {'icon': Icons.home, 'label': 'Others Bill'},
    {'icon': Icons.miscellaneous_services, 'label': 'Others Bill'},
    // {'icon': Icons.wifi, 'label': 'Others Bill'},
    // {'icon': Icons.tv, 'label': 'Others Bill'},

  ];




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ElectricityBillAccount()));
        break;
      // case 2:
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => PayableBillList()));
      //   break;
      // case 3:
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => );
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Palette.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shop-wise Demand Charge.',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 16), // Add spacing between text and grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 16, // Horizontal spacing
                    mainAxisSpacing: 16, // Vertical spacing
                    childAspectRatio: 1, // Aspect ratio of the grid items
                  ),
                  itemCount: charges.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (charges[index]['route'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => charges[index]['route'],
                            ),
                          );
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              charges[index]['icon'],
                              size: 50,
                              color: Color(0xFF2D4F52),
                            ),
                            SizedBox(height: 8),
                            Text(
                              charges[index]['label'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF2D4F52), // Pink for selected item
        unselectedItemColor: Colors.grey, // Gray for unselected items
        backgroundColor: Palette.backgroundColor,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scan QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Inbox',
          ),
        ],
      ),
    );
  }
}
