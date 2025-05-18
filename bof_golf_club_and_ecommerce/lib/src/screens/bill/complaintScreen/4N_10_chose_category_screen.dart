import 'package:book_store/config/palette.dart';
import 'package:book_store/src/screens/screen/bill/complaintScreen/4N_11_raise_complaint.dart';
import 'package:flutter/material.dart';





class StaticChoseCategoryScreen extends StatefulWidget {
  @override
  _ChoseCategoryListState createState() => _ChoseCategoryListState();
}

class _ChoseCategoryListState extends State<StaticChoseCategoryScreen> {

  String? selectedCategory;

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void navigateToRaiseComplaint() {
    if (selectedCategory != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RaiseComplaintPage(),
        ),
      );
    } else {
      // Show a message if no category is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a category")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.globalColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Choose Category',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Palette.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose the category under which your complaint falls.',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  CategoryCard(
                    icon: Icons.electrical_services,
                    color: Colors.lightBlueAccent,
                    label: 'Electrical',
                    onTap: () => selectCategory('Electrical'),
                    isSelected: selectedCategory == 'Electrical',
                  ),
                  CategoryCard(
                    icon: Icons.plumbing,
                    color: Colors.orangeAccent,
                    label: 'Plumbing',
                    onTap: () => selectCategory('Plumbing'),
                    isSelected: selectedCategory == 'Plumbing',
                  ),
                  CategoryCard(
                    icon: Icons.local_parking,
                    color: Colors.blueAccent,
                    label: 'Parking',
                    onTap: () => selectCategory('Parking'),
                    isSelected: selectedCategory == 'Parking',
                  ),
                  CategoryCard(
                    icon: Icons.elevator,
                    color: Colors.deepOrangeAccent,
                    label: 'Elevator',
                    onTap: () => selectCategory('Elevator'),
                    isSelected: selectedCategory == 'Elevator',
                  ),
                  CategoryCard(
                    icon: Icons.cleaning_services,
                    color: Colors.greenAccent,
                    label: 'Cleaning',
                    onTap: () => selectCategory('Cleaning'),
                    isSelected: selectedCategory == 'Cleaning',
                  ),
                  CategoryCard(
                    icon: Icons.security,
                    color: Colors.redAccent,
                    label: 'Security',
                    onTap: () => selectCategory('Security'),
                    isSelected: selectedCategory == 'Security',
                  ),
                  CategoryCard(
                    icon: Icons.more_horiz,
                    color: Colors.purpleAccent,
                    label: 'Others',
                    onTap: () => selectCategory('Others'),
                    isSelected: selectedCategory == 'Others',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: navigateToRaiseComplaint,
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.globalColor,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CategoryCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const CategoryCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: 2),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
