import 'package:book_store/route/routes.dart';
import 'package:flutter/material.dart';




class MembersDirectoryScreen extends StatefulWidget {
  @override
  _MembersDirectoryScreenState createState() => _MembersDirectoryScreenState();
}

class _MembersDirectoryScreenState extends State<MembersDirectoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Directory',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Color(0xFFEFF8E9), // Light background
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(),
            SizedBox(height: 12),
            MembersList(),
            SizedBox(height: 16),
            FiltersSection(),
            SizedBox(height: 16),
            Expanded(child: MessagesList()),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search members here",
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class MembersList extends StatelessWidget {
  final List<Map<String, String>> members = [
    {"name": "New", "image": "assets/liton.jpg"}, // Placeholder
    {"name": "Mehedi Hasan", "image": "assets/mehedi.jpg"},
    {"name": "Sifat Khan", "image": "assets/sifat_khan.jpg"},
    {"name": "Abdul Alim Tushar", "image": "assets/tushar_linkedin.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: members.map((member) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(member["image"]!),
                ),
                SizedBox(height: 4),
                Text(member["name"]!, style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FiltersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: Text('View Details', style: TextStyle(fontSize: 16)),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1F3B4D),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.filter);
            },
            child: Text('Apply Filters', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}

class MessagesList extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      "name": "Mehedi Hasan",
      "message": "Contacted you. Respond now!",
      "time": "Just",
      "profile": "assets/mehedi.jpg",
      "highlight": "bold"
    },
    {
      "name": "Sifat Khan",
      "message": "You: I'm concerned about the situation, but",
      "time": "12 minutes",
      "profile": "assets/sifat_khan.jpg"
    },
    {
      "name": "Md ABdul Alim Tushar",
      "message": "Hello, can you please respond? What's the",
      "time": "1 day ago",
      "profile": "assets/tushar_linkedin.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageCard(
          name: messages[index]["name"]!,
          message: messages[index]["message"]!,
          time: messages[index]["time"]!,
          profile: messages[index]["profile"]!,
          highlight: messages[index].containsKey("highlight"),
        );
      },
    );
  }
}

class MessageCard extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String profile;
  final bool highlight;

  MessageCard({required this.name, required this.message, required this.time, required this.profile, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage(profile),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, fontWeight: highlight ? FontWeight.bold : FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}
