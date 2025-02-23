// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz/modules/home/controllers/home_controller.dart';
import 'package:namaz/modules/ramadanCalender/ramadan_calender_scrren.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  int _currentIndex = 0;

  // Define pages for bottom navigation.
  // Replace the Placeholder widgets with your actual pages when available.
  final List<Widget> _pages = [
    HomeContent(),
    Placeholder(), // Placeholder for future Islamic content
    Placeholder(), // Placeholder for a Settings page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAEB), // Same light green background
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFFF5FAEB),
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Calender",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Islamic",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),


        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  HomeContent({Key? key}) : super(key: key);

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Top Section with background image and overlay
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ramadan_mubarak.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          // Icons Section (e.g., Quran, Ramadan, Qibla, etc.)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildIconButton('Quran', Icons.menu_book),
                _buildIconButton('Ramadan', Icons.star),
                _buildIconButton('Quran Audio', Icons.headphones),
                _buildIconButton('Qibla', Icons.compass_calibration),
              ],
            ),
          ),
          // Countdown Card for Ramadan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Days Left For Ramadan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTimeBox('${controller.daysLeft.value}', 'Days'),
                          _buildTimeBox('${controller.hoursLeft.value}', 'Hours'),
                          _buildTimeBox('${controller.minutesLeft.value}', 'Minutes'),
                          _buildTimeBox('${controller.secondsLeft.value}', 'Seconds'),
                        ],
                      );
                    }),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RamadanCalendarScreen()),
                    );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D4F52),
                      ),
                      child: const Text('See Full Calendar',
                      style: TextStyle(color: Colors.white),),

                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Additional Section (e.g., Ramadan info)
          const Text(
            'Ramadan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Ad Banner Placeholder
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Text('Ad Banner'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildIconButton(String label, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.greenAccent.withOpacity(0.2),
          shape: const CircleBorder(),
          child: IconButton(
            icon: Icon(icon, color: Colors.green),
            onPressed: () {
              // Handle navigation or action for this icon
            },
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildTimeBox(String value, String unit) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(unit),
      ],
    );
  }
}
