import 'package:flutter/material.dart';

class ComplaintListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Complaints"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Icon(Icons.plumbing, color: Colors.blue),
            ),
            title: Text("Plumbing Issue"),
            subtitle: Text("In progress • Last updated 2 days ago"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.shade100,
              child: Icon(Icons.cleaning_services, color: Colors.green),
            ),
            title: Text("Cleaning Service"),
            subtitle: Text("Resolved • Last updated 5 days ago"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
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
