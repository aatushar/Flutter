import 'package:flutter/material.dart';
import 'package:flutterzitproject/route/routes.dart';




class MemberSearchScreen extends StatefulWidget {
  @override
  _MemberSearchScreenState createState() => _MemberSearchScreenState();
}

class _MemberSearchScreenState extends State<MemberSearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> allMembers = [
    {"name": "Sabbir Ahmed", "image": "assets/evn1.png"},
    {"name": "Syed Mostafa Jamal", "image": "assets/md.jpg"},
    {"name": "Riyad Chowdhury", "image": "assets/evn2.png"},
    {"name": "Emily", "image": "assets/user4.jpg"},
  ];
  List<Map<String, String>> filteredMembers = [];

  @override
  void initState() {
    super.initState();
    filteredMembers = allMembers;
  }

  void filterSearch(String query) {
    setState(() {
      filteredMembers = allMembers
          .where((member) => member["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void clearSearch() {
    searchController.clear();
    setState(() {
      filteredMembers = allMembers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color(0xFFEFF8E9),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBarWidget(
              controller: searchController,
              onChanged: filterSearch,
              onClear: clearSearch,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredMembers.length,
                itemBuilder: (context, index) {
                  return MemberCard(
                    name: filteredMembers[index]["name"]!,
                    imageUrl: filteredMembers[index]["image"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;

  SearchBarWidget({required this.controller, required this.onChanged, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: "Search for a member",
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1F3B4D),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: onClear,
          child: Text('Clear'),
        ),
      ],
    );
  }
}

class MemberCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  MemberCard({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.profile);
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(imageUrl),
          ),
          title: Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
