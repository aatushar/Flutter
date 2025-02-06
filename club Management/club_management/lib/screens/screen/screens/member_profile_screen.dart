import 'package:flutter/material.dart';
import 'package:flutterzitproject/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';



class MemberProfileScreen extends StatelessWidget {
  final String profileImage = 'assets/md.jpg'; // Replace with actual image
  final String memberName = "Member Name";
  final String jobTitle = "Marketing Specialist";
  final String contactEmail = "john.smith@example.com";
  final String contactPhone = "+123 456 7890";
  final String location = "New York, USA";
  final String membership = "January 2020";
  final String interests = "Hiking, Reading, Traveling";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF5E6), // Light background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.logout, color: Colors.black),
        //   onPressed: () {
        //     Provider.of<AuthProvider>(context, listen: false).logout();
        //     Navigator.pushReplacementNamed(context, '/');
        //   },
        // ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        title: Text(
          "Member",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profileImage),
            ),
            SizedBox(height: 10),
            Text(
              memberName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("• Attending a", style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 15),

            // Job and Contact Details
            _buildInfoRow("Job title", jobTitle),
            _buildInfoRow("Contact", "member@organization.c"),
            _buildInfoRow("Contact", "Not available"),
            _buildInfoRow("Current", "3:25 PM"),
            SizedBox(height: 15),

            // Contact Details Section
            _buildSectionHeader("Contact Details:"),
            _buildHighlightBox("Email", contactEmail),
            _buildHighlightBox("Phone", contactPhone),
            SizedBox(height: 15),

            // Additional Information
            _buildSectionHeader("Additional Information:"),
            _buildHighlightBox("Location", location),
            _buildHighlightBox("Membership", membership),
            _buildHighlightBox("Interests", interests),
            SizedBox(height: 20),

            // Dial & Chat Buttons
            _buildActionButton("Dial", Icons.phone, "tel:$contactPhone"),
            SizedBox(height: 10),
            _buildActionButton("Chat", Icons.chat, "sms:$contactPhone"),
          ],
        ),
      ),


    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[700]),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildHighlightBox(String label, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.lightGreen[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: RichText(
        text: TextSpan(
          text: "$label  ",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, String url) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2D4F52),
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            print("Could not launch $url");
          }
        },
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
