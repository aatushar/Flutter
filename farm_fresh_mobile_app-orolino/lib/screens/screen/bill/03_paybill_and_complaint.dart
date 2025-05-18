import 'package:book_store/config/palette.dart';
import 'package:book_store/screens/screen/bill/04_bill_account_details.dart';
import 'package:book_store/screens/screen/bill/07_A_previous_bill_list_screen.dart';
import 'package:flutter/material.dart';


// Import the target page

class PaybillAndComplaint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor, // Background color
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 1,
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SYED MOSTAFA JAMAL",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                Text(
                  "A/4",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage:
              AssetImage('assets/images/user/mostafa2.jpeg'),
              radius: 18,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history, size: 30),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PreviousBillListScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Background Image Banner
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/user/golf2.jpg',
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Grid Menu
            Expanded(
              child: GridView.count(
                crossAxisCount: 3, // 3 buttons per row
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuButton(
                      'assets/images/icons/new/mobile-payment.png',
                      "Pay Bill",
                      context,
                      ElectricityBillAccountDetails()),
                  _buildMenuButton(
                      'assets/images/icons/new/complain.jpg',
                      "Complain",
                      context,
                      null),
                  _buildMenuButton(
                      'assets/images/icons/new/history.png',
                      "History",
                      context,
                      PreviousBillListScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("SYED MOSTAFA JAMAL"),
              accountEmail: Text("A/4"),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                AssetImage("assets/images/user/mostafa2.jpeg"),
              ),
              decoration: BoxDecoration(color: Palette.backgroundColor),
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('Pay Bill'),
              leading: Icon(Icons.payment),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ElectricityBillAccountDetails()),
                );
              },
            ),
            ListTile(
              title: Text('Complain'),
              leading: Icon(Icons.report_problem),
              onTap: () {},
            ),
            ListTile(
              title: Text('Notification'),
              leading: Icon(Icons.notifications),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('Change PIN'),
              leading: Icon(Icons.lock),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('Log Out', style: TextStyle(color: Colors.red)),
              leading: Icon(Icons.logout, color: Colors.red),
              onTap: () {},
            ),
            ListTile(
              title: Text('Close'),
              leading: Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create menu buttons
  Widget _buildMenuButton(
      String imagePath, String label, BuildContext context, Widget? navigateTo) {
    return GestureDetector(
      onTap: () {
        if (navigateTo != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigateTo),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 40, width: 40, fit: BoxFit.cover),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
