import 'package:book_store/config/palette.dart';
import 'package:book_store/screens/screen/bill/03_paybill_and_complaint.dart';
import 'package:flutter/material.dart';



class ElectricityBillAccount extends StatefulWidget {
  @override
  _ElectricityBillAccountState createState() => _ElectricityBillAccountState();
}

class _ElectricityBillAccountState extends State<ElectricityBillAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        backgroundColor: Palette.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "A/4",
              style: TextStyle(
                  color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/user/mostafa2.jpeg'), // Profile image
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Centered Image
              Center(
                child: Image.asset(
                  'assets/images/user/billpay.jpg',
                  height: 220,
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

              // Account Cards (Two different bill lists)
              AccountCard(
                name: "SYED MOSTAFA JAMAL",
                accountType: "Club Bill",
                accountNumber: "21010459",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaybillAndComplaint()),
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
  final String accountType;
  final String accountNumber;
  final VoidCallback onPressed; // Callback for navigation

  const AccountCard({
    Key? key,
    required this.name,
    required this.accountType,
    required this.accountNumber,
    required this.onPressed, // Pass onPressed parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Make the whole card clickable
      child: Container(
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Palette.backgroundColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    accountType,
                    style: const TextStyle(
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
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
