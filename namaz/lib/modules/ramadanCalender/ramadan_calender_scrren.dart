import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RamadanCalendarController extends GetxController {
  final List<Map<String, String>> ramadanSchedule = [
    {"no": "1", "date": "1 March", "day": "Sat", "suhoor": "05:05", "iftar": "18:01"},
    {"no": "2", "date": "2 March", "day": "Sun", "suhoor": "05:04", "iftar": "18:02"},
    {"no": "3", "date": "3 March", "day": "Mon", "suhoor": "05:04", "iftar": "18:02"},
    {"no": "4", "date": "4 March", "day": "Tue", "suhoor": "05:03", "iftar": "18:03"},
    {"no": "5", "date": "5 March", "day": "Wed", "suhoor": "05:02", "iftar": "18:03"},
    {"no": "6", "date": "6 March", "day": "Thu", "suhoor": "05:01", "iftar": "18:04"},
    {"no": "7", "date": "7 March", "day": "Fri", "suhoor": "05:00", "iftar": "18:04"},
    {"no": "8", "date": "8 March", "day": "Sat", "suhoor": "04:59", "iftar": "18:04"},
    {"no": "9", "date": "9 March", "day": "Sun", "suhoor": "04:58", "iftar": "18:05"},
    {"no": "10", "date": "10 March", "day": "Mon", "suhoor": "04:57", "iftar": "18:05"},
    {"no": "11", "date": "11 March", "day": "Tue", "suhoor": "04:56", "iftar": "18:06"},
    {"no": "12", "date": "12 March", "day": "Wed", "suhoor": "04:55", "iftar": "18:06"},
    {"no": "13", "date": "13 March", "day": "Thu", "suhoor": "04:54", "iftar": "18:07"},
    {"no": "14", "date": "14 March", "day": "Fri", "suhoor": "04:53", "iftar": "18:07"},
    {"no": "15", "date": "15 March", "day": "Sat", "suhoor": "04:52", "iftar": "18:07"},
    {"no": "16", "date": "16 March", "day": "Sun", "suhoor": "04:51", "iftar": "18:08"},
    {"no": "17", "date": "17 March", "day": "Mon", "suhoor": "04:50", "iftar": "18:08"},
    {"no": "18", "date": "18 March", "day": "Tue", "suhoor": "04:49", "iftar": "18:09"},
    {"no": "19", "date": "19 March", "day": "Wed", "suhoor": "04:48", "iftar": "18:09"},
    {"no": "20", "date": "20 March", "day": "Thu", "suhoor": "04:47", "iftar": "18:10"},
    {"no": "21", "date": "21 March", "day": "Fri", "suhoor": "04:46", "iftar": "18:10"},
    {"no": "22", "date": "22 March", "day": "Sat", "suhoor": "04:45", "iftar": "18:10"},
    {"no": "23", "date": "23 March", "day": "Sun", "suhoor": "04:44", "iftar": "18:11"},
    {"no": "24", "date": "24 March", "day": "Mon", "suhoor": "04:43", "iftar": "18:11"},
    {"no": "25", "date": "25 March", "day": "Tue", "suhoor": "04:42", "iftar": "18:12"},
    {"no": "26", "date": "26 March", "day": "Wed", "suhoor": "04:41", "iftar": "18:12"},
    {"no": "27", "date": "27 March", "day": "Thu", "suhoor": "04:40", "iftar": "18:12"},
    {"no": "28", "date": "28 March", "day": "Fri", "suhoor": "04:39", "iftar": "18:13"},
    {"no": "29", "date": "29 March", "day": "Sat", "suhoor": "04:38", "iftar": "18:13"},
    {"no": "30", "date": "30 March", "day": "Sun", "suhoor": "04:37", "iftar": "18:13"},
  ];
}

class RamadanCalendarScreen extends StatelessWidget {
  RamadanCalendarScreen({Key? key}) : super(key: key);

  final RamadanCalendarController controller = Get.put(RamadanCalendarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Column(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ramadan_karim.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Title and Location
          Container(
            width: double.infinity,
            color: Colors.green.shade800,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: const [
                Text(
                  "Ramadan Calendar 2025",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  "Dhaka, Bangladesh",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),

          // Wrapping Table Header and ListView in Expanded Column
          Expanded(
            child: Column(
              children: [
                // Table Header
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.brown.shade700,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("No.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("Date", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("Day", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("Suhoor", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("Iftar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),

                // Expanded ListView to ensure no gap issue
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.ramadanSchedule.length,
                    itemBuilder: (context, index) {
                      var item = controller.ramadanSchedule[index];
                      return Container(
                        color: index % 2 == 0 ? Colors.white : Colors.grey.shade200,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(item["no"]!),
                            Text(item["date"]!),
                            Text(item["day"]!),
                            Text(item["suhoor"]!),
                            Text(item["iftar"]!),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
