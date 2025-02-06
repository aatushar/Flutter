import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterzitproject/config/palette.dart';
import 'package:flutterzitproject/screens/screen/bill/05_monthly_board_rent.dart';

class ElectricityBillAccountDetails extends StatefulWidget {
  @override
  _ElectricityBillAccountState createState() => _ElectricityBillAccountState();
}

class _ElectricityBillAccountState extends State<ElectricityBillAccountDetails> {
  int _page = 3; // Default to this page in the bottom navigation

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
  GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Handle menu action
          },
        ),
        title: Text(
          "All Bill",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
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
              // Centered Image
              Center(
                child: Image.asset(
                  'assets/images/user/paynow.png',
                  height: 140,
                  fit: BoxFit.cover,
                ),
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
                invoiceNo: "21010459",
                amount: 6000.25,
                status: "6000.25",
                isDue: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MonthlyBoardRentServiceScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
              AccountCard(
                name: "SYED MOSTAFA JAMAL",
                invoiceNo: "33011302",
                amount: 5000,
                status: "5000",
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

    );
  }
}

class AccountCard extends StatelessWidget {
  final String name;
  final String invoiceNo;
  final double amount;
  final String status;
  final bool isDue;
  final VoidCallback onPressed; // Callback for button press

  const AccountCard({
    Key? key,
    required this.name,
    required this.invoiceNo,
    required this.amount,
    required this.status,
    required this.isDue,
    required this.onPressed, // Pass onPressed parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2D4F52),
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
            "Invoice No: $invoiceNo",
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
                style: TextStyle(color: Palette.globalColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
