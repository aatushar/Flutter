import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scb_payment_tushar/screen/bill/4N_04_paybale_bill_list.dart';
import 'package:scb_payment_tushar/screen/bill/4N_05_monthly_board_rent.dart';
import 'package:scb_payment_tushar/screen/home.dart';
import 'package:scb_payment_tushar/screen/notification_list.dart';
import '../../config/palette.dart';

class ElectricityBillAccount extends StatefulWidget {
  @override
  _ElectricityBillAccountState createState() => _ElectricityBillAccountState();
}

class _ElectricityBillAccountState extends State<ElectricityBillAccount> {
  int _page = 3; // Default to this page in the bottom navigation

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
  GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.primaryBG,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            // Handle menu action
          },
        ),
        title: Text(
          "Electricity Bill",
          style: TextStyle(
            color: Palette.textClr,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notifications action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section with Text and Image
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "We work to",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "enlighten",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.primaryBG,
                                ),
                              ),
                              TextSpan(
                                text: "\n the city",
                                style:
                                TextStyle(fontSize: 24, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Image.asset(
                    'assets/images/user/Electricity.png',
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // My Accounts Label
              Text(
                "My Accounts",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),

              // Account Cards
              AccountCard(
                name: "SYED MOSTAFA JAMAL",
                accountNumber: "21010459",
                amount: 16112.25,
                status: "16112.25",
                isDue: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              const SizedBox(height: 16),
              AccountCard(
                name: "MD. MOKSHED ALI MIA",
                accountNumber: "33011302",
                amount: 0.00,
                status: "No Due",
                isDue: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MonthlyBoardRentServiceScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      //this section for the footer
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
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
          Icon(Icons.arrow_right, size: 60, color: Colors.white),
        ],
        color: Palette.primaryBG,
        buttonBackgroundColor: Palette.primaryBG,
        backgroundColor: Palette.backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 200),
        onTap: (index) {
          setState(() {
            _page = index;
            if (_page == 0) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            } else if (_page == 1) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NotificationPage()));
            } else if (_page == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PayableBillList()));
            } else if (_page == 3) {
             Navigator.push(context, MaterialPageRoute(builder: (context)=> ElectricityBillAccount()));
            } else if (_page == 4) {
              // Handle arrow navigation or other actions
            }
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final String name;
  final String accountNumber;
  final double amount;
  final String status;
  final bool isDue;
  final VoidCallback onPressed; // Callback for button press

  const AccountCard({
    Key? key,
    required this.name,
    required this.accountNumber,
    required this.amount,
    required this.status,
    required this.isDue,
    required this.onPressed, // Pass onPressed parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.primaryBG,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Palette.Shadow50,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "POSTPAID",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Acc: $accountNumber",
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),

          // Bill Information
          const Text(
            "Total Bill amount",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            "৳${amount.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(
              color: isDue ? Colors.red : Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Pay Bill Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Pay Bill",
                style: TextStyle(color: Palette.primaryBG),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
