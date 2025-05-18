import 'package:book_store/config/palette.dart';
import 'package:book_store/src/screens/screen/bill/complaintScreen/4N_09_track_complaint_.dart';
import 'package:book_store/src/screens/screen/bill/complaintScreen/4N_10_chose_category_screen.dart';
import 'package:flutter/material.dart';


class MyComplaintsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.globalColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Navigates back to the previous page
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "SYED MOSTAFA JAMAL",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "A/4",
                style: TextStyle(
                    color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          actions: [
            CircleAvatar(
              backgroundImage:
              AssetImage('assets/images/user/mostafa2.jpeg'), // Profile image
            ),
            const SizedBox(width: 10),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFFE0E0E0),
            indicatorColor: Colors.red,
            tabs: [
              Tab(text: 'Raised'),
              Tab(text: 'In Progress'),
              Tab(text: 'Resolved'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ComplaintsList(statusFilter: "Raised"),
            ComplaintsList(statusFilter: "In Progress"),
            ComplaintsList(statusFilter: "Resolved"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StaticChoseCategoryScreen()),
            );
          },
          backgroundColor: Palette.globalColor,
          child: Icon(Icons.edit, color: Colors.white),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: Colors.blue,
        //   unselectedItemColor: Colors.grey,
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        //     BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Users'),
        //     BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        //   ],
        // ),
      ),
    );
  }
}

class ComplaintsList extends StatelessWidget {
  final String statusFilter;

  const ComplaintsList({required this.statusFilter});

  @override
  Widget build(BuildContext context) {
    // Sample complaint data filtered by status
    List<ComplaintCard> complaints = [];

    // Only add complaints that match the current statusFilter
    if (statusFilter == "Raised") {
      complaints = [
        ComplaintCard(
          statusColor: Colors.orange,
          statusText: "Raised",
          ticketNumber: "#101",
          title: "Lighting Issue",
          description: "The corridor light is flickering.",
          imageUrl: "https://tappselectric.com/wp-content/uploads/2021/12/commercial-lighting-bulb-768x432.png",
          actions: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue),
              ),
              child: Text("Cancel"),
            ),
          ],
        ),
        ComplaintCard(
          statusColor: Colors.orange,
          statusText: "Raised",
          ticketNumber: "#102",
          title: "Broken Window",
          description: "The window in the living room is broken and needs repair.",
          imageUrl: "https://www.britanniaglass.co.uk/wp-content/uploads/2023/04/open-broken-window-2023-1200x900.jpg",
          actions: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue),
              ),
              child: Text("Cancel"),
            ),
          ],
        ),
        ComplaintCard(
          statusColor: Colors.orange,
          statusText: "Raised",
          ticketNumber: "#103",
          title: "Heating Issue",
          description: "The heater in the main bedroom is not working.",
          imageUrl: "https://folitechplumbing.com/wp-content/uploads/2024/08/Article-Image-2-Folitech-Plumbing-Heating-Limited-min.jpg",
          actions: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue),
              ),
              child: Text("Cancel"),
            ),
          ],
        ),
      ];
    } else if (statusFilter == "In Progress") {
      complaints = [
        ComplaintCard(
          statusColor: Colors.blue,
          statusText: "In Progress",
          ticketNumber: "#214",
          title: "Plumbing",
          description: "Water tap and sink pipe leakage, needs urgent work by plumber.",
          imageUrl: "https://img.freepik.com/free-vector/plumber-service-concept_1284-6234.jpg?semt=ais_siglip",
          actions: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue),
              ),
              child: Text("Withdraw"),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TrackComplaintPage()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue),
              ),
              child: Text("Track"),
            ),
          ],
        ),
      ];
    } else if (statusFilter == "Resolved") {
      complaints = [
        ComplaintCard(
          statusColor: Colors.green,
          statusText: "Resolved",
          ticketNumber: "#207",
          title: "Electrical",
          description: "Switch board near the kitchen not working from the last 2 days.",
          imageUrl: "https://img.freepik.com/free-vector/electrician-service-squared-flyer-template_23-2149007555.jpg?semt=ais_siglip",
          actions: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue),
              ),
              child: Text("Reopen Complaint"),
            ),
          ],
          resolvedDetails: "Your complaint was successfully resolved by Ghoreesh Rana on 25 Feb, 3:45 PM",
          rating: 4,
        ),
      ];
    }

    return Container(
      color: Palette.backgroundColor, // Set the background color
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: complaints,
      ),
    );
  }
}

class ComplaintCard extends StatelessWidget {
  final Color statusColor;
  final String statusText;
  final String ticketNumber;
  final String title;
  final String description;
  final String imageUrl;
  final List<Widget> actions;
  final String? resolvedDetails;
  final int? rating;

  const ComplaintCard({
    required this.statusColor,
    required this.statusText,
    required this.ticketNumber,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.actions,
    this.resolvedDetails,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 5, backgroundColor: statusColor),
                SizedBox(width: 8),
                Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.w600)),
                Spacer(),
                Text(ticketNumber, style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(imageUrl, width: 64, height: 64, fit: BoxFit.cover),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(description, style: TextStyle(color: Colors.grey[600])),
                      if (resolvedDetails != null) ...[
                        SizedBox(height: 8),
                        Text(
                          resolvedDetails!,
                          style: TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (actions.isNotEmpty) ...[
              SizedBox(height: 16),
              Row(children: actions),
            ],
            if (rating != null) ...[
              SizedBox(height: 16),
              Row(
                children: [
                  Text("Rate the service", style: TextStyle(color: Colors.grey[700])),
                  Spacer(),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating! ? Icons.star : Icons.star_border,
                        color: index < rating! ? Colors.yellow[600] : Colors.grey[300],
                        size: 20,
                      );
                    }),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
