import 'package:flutter/material.dart';
import 'package:flutterzitproject/route/routes.dart';

class EventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'ClubAp',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1F3B4D),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.book);
            },
            child: Text('My Events'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Color(0xFFEFF8E9), // Light background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upcoming Events',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  EventCard(
                    imageUrl: 'assets/evn1.png', // Replace with real image URL
                    title: 'Community Festival',
                    date: 'May 15, 2025',
                    location: 'Central Park',
                  ),
                  EventCard(
                    imageUrl: 'assets/Joy-Bangla-Concert-2023.jpg', // Replace with real image URL
                    title: 'Live Concert',
                    date: 'February 21 ,2025',
                    location: 'Army Stadium',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String location;

  EventCard({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('Date: $date'),
                Text('Location: $location'),
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1F3B4D),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.add);
                    },
                    child: Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
