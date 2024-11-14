import 'package:flutter/material.dart';

class ComplaintListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Complaints"),
      ),
      body: Center(
        child: Text("List of complaints goes here"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/category');
        },
        child: Icon(Icons.add),
        tooltip: 'Raise a Complaint',
      ),
    );
  }
}
