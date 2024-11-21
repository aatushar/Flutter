import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scb_payment_tushar/screen/bill/4N_04_electricity_bill_account.dart';
import 'package:scb_payment_tushar/screen/bill/4N_07_payment_history.dart';
import 'package:scb_payment_tushar/screen/bill/4N_04_paybale_bill_list.dart';
// Example screen import
import 'package:scb_payment_tushar/screen/complaintScreen/4N_08_my_complaints.dart';
import '../../config/palette.dart';

class MonthlyBoardRentServiceScreen extends StatefulWidget {
  @override
  _MonthlyBoardRentServiceScreenState createState() =>
      _MonthlyBoardRentServiceScreenState();
}

class _MonthlyBoardRentServiceScreenState
    extends State<MonthlyBoardRentServiceScreen> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
  GlobalKey(); // Key for CurvedNavigationBar
  int _page = 0; // Default page index for navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryBG,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous page
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              "SYED MOSTAFA JAMAL",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "A/4",
              style: TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundImage:
            AssetImage('assets/images/user/mostafa2.jpeg'), // Profile image
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Palette.backgroundColor, // Background color updated
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Title and Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.square, color: Palette.primaryBG, size: 24),
                      SizedBox(width: 8),
                      Text(
                        "Monthly Board Rent &\nService - Oct-24",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                  Text(
                    "BDT 16112.25 /-",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "A/4",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Rent Details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Board Rent:", style: TextStyle(fontSize: 16)),
                  Text("3255/-", style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Service Charge:", style: TextStyle(fontSize: 16)),
                  Text("12369/-", style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("VAT:", style: TextStyle(fontSize: 16)),
                  Text("488.25/-", style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 16),

              // Due Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Due Date:", style: TextStyle(fontSize: 16)),
                  Text(
                    "2024-11-10",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(height: 32, color: Colors.grey),

              // Total Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Total Amount",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "16112.25/-",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar (CurvedNavigationBar added here)
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page, // Default selected index
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.notifications_on, size: 30, color: Colors.white),
          Image.asset(
            'assets/images/icons/new/pay_icon.png',
            height: 45.0,
            width: 45.0,
            fit: BoxFit.cover,
          ),
          Icon(Icons.history, size: 30, color: Colors.white),
          Icon(Icons.thumb_down, size: 30, color: Colors.white),
        ],
        color: Palette.primaryBG, // Background color of the bar
        buttonBackgroundColor: Palette.primaryBG, // Active button background
        backgroundColor: Palette.backgroundColor, // Bar background color
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            _page = index; // Update the selected page index
            if (_page == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ElectricityBillAccount())); // Replace with actual screen
            } else if (_page == 1) {
              // Handle notifications navigation
            } else if (_page == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PayableBillList())); // Payable bills
            } else if (_page == 3) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentHistory())); // Payment history
            } else if (_page == 4) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyComplaintsPage())); // Complaints
            }
          });
        },
        letIndexChange: (index) => true, // Allow index change
      ),
    );
  }
}
