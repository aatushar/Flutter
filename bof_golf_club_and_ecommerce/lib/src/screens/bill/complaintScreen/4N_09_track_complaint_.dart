import 'package:book_store/config/palette.dart';
import 'package:flutter/material.dart';


class TrackComplaintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.globalColor, // Replace with your desired color
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
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          actions: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/user/mostafa2.jpeg'), // Profile image
            ),
            const SizedBox(width: 10),
          ],
        ),
        backgroundColor: Palette.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Complaint Details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://img.freepik.com/free-vector/plumber-service-concept_1284-6234.jpg?semt=ais_siglip',
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plumbing',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Ticket no. #214',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Water tap and sink pipe leakage, needs urgent work by plumber.',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Timeline Section
              Text(
                'Complaint In Progress',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: const [
                    TimelineTile(
                      title: 'Complaint Raised',
                      date: 'Mon, 19 Oct 20',
                      description: 'Your complaint has been raised at 2:32 PM',
                      isCompleted: true,
                    ),
                    TimelineTile(
                      title: 'Task Assigned',
                      date: 'Mon, 19 Oct 20',
                      description:
                      'Admin has assigned the task to Dhoorat Kishan who will attend your complaint around 6',
                      isCompleted: true,
                    ),
                    TimelineTile(
                      title: 'Staff on Site',
                      date: 'Mon, 19 Oct 20',
                      description:
                      'Staff started attending your complaint at 5:45 PM\nComplaint deferred due to unavailability of required tools',
                      isCompleted: false,
                      isInProgress: true,
                    ),
                    TimelineTile(
                      title: 'Complaint Resolved',
                      date: '',
                      description: '',
                      isCompleted: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Attending Staff Section
              Text(
                'Attending Staff',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRU-4enTcHq-YxJtauOv07ts8SwkCpBvNz7A&s'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mr Rafiq Miah',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[600], size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '4.6 · 126 resolutions · 27 Reviews',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: Palette.globalColor,
                    onPressed: () {},
                    child: const Icon(Icons.phone, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Withdraw',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Remind',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimelineTile extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final bool isCompleted;
  final bool isInProgress;

  const TimelineTile({
    required this.title,
    required this.date,
    required this.description,
    this.isCompleted = false,
    this.isInProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? Colors.green
                    : (isInProgress ? Colors.blue : Colors.grey),
              ),
            ),
            Container(
              width: 2,
              height: 40,
              color: Colors.grey[300],
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title  $date',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
