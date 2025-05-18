import 'package:book_store/route/routes.dart';
import 'package:flutter/material.dart';



class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? selectedCategory;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void resetFilters() {
    setState(() {
      selectedCategory = null;
      nameController.clear();
      locationController.clear();
    });
  }

  void applyFilters() {
    // Implement filter logic
    print("Filters Applied:");
    print("Name: ${nameController.text}");
    print("Location: ${locationController.text}");
    print("Category: $selectedCategory");

    Navigator.pushNamed(context, AppRoutes.filtermain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF5E6), // Light green background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Filter",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Input
            _buildLabel("Name"),
            _buildTextField(nameController),

            SizedBox(height: 10),

            // Location Input
            _buildLabel("Location"),
            _buildTextField(locationController),

            SizedBox(height: 20),

            // Category Selection
            _buildLabel("Category"),
            _buildCategorySelection(),

            SizedBox(height: 30),

            // Apply & Reset Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton("Apply", applyFilters),
                _buildButton("Reset", resetFilters),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCategorySelection() {
    return Column(
      children: ["Male", "Female", "Kid"].map((category) {
        return RadioListTile<String>(
          title: Text(category),
          value: category,
          groupValue: selectedCategory,
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF2D4F52), // Dark teal button
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
