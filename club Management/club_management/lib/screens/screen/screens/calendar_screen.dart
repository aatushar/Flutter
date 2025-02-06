import 'package:flutter/material.dart';


class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAEB), // Light green background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.calendar_month, color: Colors.black),
            SizedBox(width: 10),
            Text("ClubApp", style: TextStyle(color: Colors.black, fontSize: 20)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2D4F52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Add Event", style: TextStyle(color: Colors.white)),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_left, size: 30),
                    ),
                    const Text(
                      "October 2023",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_right, size: 30),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Calendar View (Simplified)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.5,
              ),
              itemCount: 31,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Upcoming Events",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  EventCard(
                    title: "Club Annual Gala",
                    dateTime: "October 15, 2023 | 7:00 PM",
                    description: "Join us for an evening of celebration and networking at the Annual Gala. Enjoy exquisite food and entertainment.",
                  ),
                  EventCard(
                    title: "Wine Tasting Event",
                    dateTime: "October 22, 2023 | 5:00 PM",
                    description: "Experience a selection of fine wines from around the world, paired with gourmet bites.",
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
  final String title;
  final String dateTime;
  final String description;

  const EventCard({super.key, required this.title, required this.dateTime, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(dateTime, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 5),
            Text(description, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
