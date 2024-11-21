import 'package:flutter/material.dart';
import 'package:scb_payment_tushar/screen/bill/4N_04_electricity_bill_account.dart';

class ShopWiseDemandCharge extends StatelessWidget {
  final List<Map<String, dynamic>> charges = [
    {
      'icon': Icons.electrical_services,
      'label': 'Electric Bill',
      'route': ElectricityBillAccount(),
    },
    {'icon': Icons.water, 'label': 'Water Bill'},
    {'icon': Icons.security, 'label': 'Security Bill'},
    {'icon': Icons.account_balance, 'label': 'Holding Tax'},
    {'icon': Icons.home, 'label': 'Rent'},
    {'icon': Icons.miscellaneous_services, 'label': 'Service Charge'},
    {'icon': Icons.wifi, 'label': 'Internet Bill'},
    {'icon': Icons.tv, 'label': 'Dish Bill'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7F9), // Light teal background
      body: Column(
        children: [
          // Title Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 45.0, 0.0, 8.0),
            child: Align(
              alignment: Alignment.centerLeft, // Align text to the left
              child: Text(
                'Shop-wise Demand Charge',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008080), // Teal text color
                  letterSpacing: 1.2, // Slight spacing between letters
                ),
              ),
            ),
          ),
          // Grid Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Left and right padding for grid
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
                            color: Colors.blue,
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
    );
  }
}
