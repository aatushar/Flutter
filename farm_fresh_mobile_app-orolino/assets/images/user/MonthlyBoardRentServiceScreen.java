import 'package:flutter/material.dart';
import 'package:flutterzitproject/config/palette.dart';
import 'package:flutterzitproject/screens/screen/bill/06_pay_bill_status.dart';

class MonthlyBoardRentServiceScreen extends StatefulWidget {
  @override
  _MonthlyBoardRentServiceScreenState createState() =>
      _MonthlyBoardRentServiceScreenState();
}

class _MonthlyBoardRentServiceScreenState
    extends State<MonthlyBoardRentServiceScreen> {
  
  // Golf Accessories Prices
  final double golfBalls = 3500.0;
  final double golfGloves = 1200.0;
  final double golfShoes = 5500.0;
  final double golfBag = 4700.0;
  final double golfTees = 350.0;
  final double golfCap = 1000.0;

  final double otherCharges = 500.0; // Club Maintenance Fee + Locker Rental
  
  @override
  Widget build(BuildContext context) {
    double subtotal = golfBalls + golfGloves + golfShoes + golfBag + golfTees + golfCap;
    double vat = subtotal * 0.10; // 10% VAT
    double totalAmount = subtotal + vat + otherCharges;

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
            backgroundImage: AssetImage('assets/images/user/mostafa2.jpeg'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        color: Palette.backgroundColor, 
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
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
                              Icon(Icons.golf_course, color: Color(0xFF2D4F52), size: 24),
                              SizedBox(width: 8),
                              Text(
                                "Golf Club Equipment Bill - Jan 2025",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                          Text(
                            "BDT ${subtotal.toStringAsFixed(2)} /-",
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
                        "BF Golf Club",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),

                      // Golf Club Equipment Details
                      _buildBillRow("Premium Golf Balls (Pack of 12):", golfBalls),
                      _buildBillRow("Golf Gloves (Pair):", golfGloves),
                      _buildBillRow("Golf Shoes (Waterproof):", golfShoes),
                      _buildBillRow("Golf Club Bag:", golfBag),
                      _buildBillRow("Golf Tees (Pack of 50):", golfTees),
                      _buildBillRow("Golf Cap (UV Protection):", golfCap),

                      const Divider(height: 32, color: Colors.grey),

                      // VAT Section
                      _buildBillRow("VAT (10%):", vat),

                      // Other Charges Section
                      _buildBillRow("Other Charges:", otherCharges),

                      const Divider(height: 32, color: Colors.grey),

                      // Total Amount Section
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: Palette.backgroundColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Total Amount
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "BDT ${totalAmount.toStringAsFixed(2)} /-",
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Pay Now Button
            Container(
              width: double.infinity,
              color: Palette.backgroundColor,
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D4F52),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PayBillStatus()),
                  );
                },
                child: Center(
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build bill row
  Widget _buildBillRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Text("${amount.toStringAsFixed(2)} /-", style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
