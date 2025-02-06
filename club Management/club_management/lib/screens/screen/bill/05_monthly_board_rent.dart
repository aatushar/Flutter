import 'package:flutter/material.dart';
import 'package:flutterzitproject/config/palette.dart';
import 'package:flutterzitproject/screens/screen/bill/06_pay_bill_status.dart';
import 'package:flutterzitproject/screens/screen/bill/06_payment_gateway__checkout.dart';


class MonthlyBoardRentServiceScreen extends StatefulWidget {
  @override
  _MonthlyBoardRentServiceScreenState createState() =>
      _MonthlyBoardRentServiceScreenState();
}

class _MonthlyBoardRentServiceScreenState
    extends State<MonthlyBoardRentServiceScreen> {
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
        color: Palette.backgroundColor, // ✅ Ensures background color for the whole screen
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
                              Icon(Icons.square, color:Color(0xFF2D4F52), size: 24),
                              SizedBox(width: 8),
                              Text(
                                "Monthly Bill &\nService Charge - Jan-25",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                          Text(
                            "BDT 6000.25 /-",
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
                          Text("Monthly Club Subscription Fee:", style: TextStyle(fontSize: 16)),
                          Text("5000.25/-", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Service Charge:", style: TextStyle(fontSize: 16)),
                          Text("500/-", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("VAT:", style: TextStyle(fontSize: 16)),
                          Text("500/-", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Due Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Due Date:", style: TextStyle(fontSize: 16)),
                          Text(
                            "2025-01-31",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(height: 32, color: Colors.grey),

                      // Total Amount Section (Inside a Background Colored Container)
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: Palette.backgroundColor, // ✅ Background color applied
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Total Amount
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "6000.25/-",
                                  style: TextStyle(
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
            // Pay Now Button (Inside the Same Background Container)
            Container(
              width: double.infinity,
              color: Palette.backgroundColor, // ✅ Background color continues
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
                        builder: (context) => Checkout()),
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
}
