import 'package:flutter/material.dart';
import 'package:flutterzitproject/route/routes.dart';

class BookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClubAp'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Color(0xFFEFF8E9), // Light greenish background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Alex!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Membership Status: Premium - Valid until 12/2023',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Text(
              'Quick Access',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                QuickAccessButton(label: 'Book Golf',routeName: AppRoutes.hallroombook),
                SizedBox(width: 8),
                QuickAccessButton(label: 'Book Room',routeName: AppRoutes.hallroombook),
                SizedBox(width: 8),
                QuickAccessButton(label: 'Events',routeName: AppRoutes.evn),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Upcoming Events',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            EventCard(
              title: 'Annual Golf Tournament',
              date: '10/11/2023',
              time: '9:00 AM',
            ),
            SizedBox(height: 20),
            Text(
              'Recent Notifications',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            NotificationCard(
              message: 'Your room booking for 12/11/2023 has been confirmed.',
            ),
          ],
        ),
      ),
    );
  }
}

class QuickAccessButton extends StatelessWidget {
  final String label;
  final String routeName;
  QuickAccessButton({required this.label, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF1F3B4D),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Text(label),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  EventCard({required this.title, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('Date: $date, Time: $time'),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String message;

  NotificationCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(message),
      ),
    );
  }
}
