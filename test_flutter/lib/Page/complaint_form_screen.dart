import 'package:flutter/material.dart';

class ComplaintFormScreen extends StatelessWidget {
  final TextEditingController _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Raise Complaint"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(
                labelText: "Tell us your problem",
                hintText: "Describe your issue",
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/confirmation');
              },
              child: Text("Submit Complaint"),
            ),
          ],
        ),
      ),
    );
  }
}
