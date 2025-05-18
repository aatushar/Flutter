import 'package:flutter/material.dart';

class ViewNotice extends StatelessWidget {
  final String title;
  final String description;
  final String dateTime;
  final String type;

  ViewNotice({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.type,
  });

  Icon getTypeIcon() {
    switch (type) {
      case 'bill':
        return Icon(Icons.receipt_long, size: 40, color: Colors.green);
      case 'complaint':
        return Icon(Icons.report_problem, size: 40, color: Colors.redAccent);
      default:
        return Icon(Icons.notifications, size: 40);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notice Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTypeIcon(),
            SizedBox(height: 20),
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(dateTime, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}
