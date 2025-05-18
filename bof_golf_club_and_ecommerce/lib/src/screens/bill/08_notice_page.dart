
import 'package:book_store/src/screens/screen/bill/09_view_notice_Page.dart';
import 'package:flutter/material.dart';


class NoticPage extends StatelessWidget {
  final List<Map<String, String>> notices = [
    {
      'title': 'Electricity Bill Paid',
      'description': 'Your electricity bill of \$75.00 was successfully paid.',
      'dateTime': '2025-05-13 08:11 AM',
      'type': 'bill',
    },
    {
      'title': 'Internet Bill Reminder',
      'description': 'Your internet bill is due on 2025-05-15. Please pay to avoid disconnection.',
      'dateTime': '2025-05-13 07:45 AM',
      'type': 'bill',
    },
    {
      'title': 'Complaint Received',
      'description': 'We have received your complaint about water leakage. It is under review.',
      'dateTime': '2025-05-13 07:00 AM',
      'type': 'complaint',
    },
    {
      'title': 'Complaint Resolved',
      'description': 'The complaint regarding streetlight outage has been resolved. Thank you.',
      'dateTime': '2025-05-12 06:30 PM',
      'type': 'complaint',
    },
  ];

  Icon getTypeIcon(String? type) {
    switch (type) {
      case 'bill':
        return Icon(Icons.receipt_long, color: Colors.green);
      case 'complaint':
        return Icon(Icons.report_problem, color: Colors.redAccent);
      default:
        return Icon(Icons.notifications);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notices')),
      body: ListView.builder(
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return ListTile(
            leading: getTypeIcon(notice['type']),
            title: Text(notice['title'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notice['description'] ?? ''),
                SizedBox(height: 4),
                Text(
                  notice['dateTime'] ?? '',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ViewNotice(
                    title: notice['title'] ?? '',
                    description: notice['description'] ?? '',
                    dateTime: notice['dateTime'] ?? '',
                    type: notice['type'] ?? '',
                  ),
                ),
              );
            },
          );
        },
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
