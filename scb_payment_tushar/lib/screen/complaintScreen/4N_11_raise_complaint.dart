import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '4N_12_confirmation_complaint_mgt.dart';

class RaiseComplaintPage extends StatefulWidget {
  const RaiseComplaintPage({super.key});

  @override
  _RaiseComplaintPageState createState() => _RaiseComplaintPageState();
}

class _RaiseComplaintPageState extends State<RaiseComplaintPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  String selectedProblem = 'Dripping faucets';
  bool isUrgent = false;
  String selectedType = 'Private';
  String? selectedSlot;

  Future<void> _pickImage() async {
    final pickedFile = await showDialog<XFile?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          actions: [
            TextButton(
              onPressed: () async {
                final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                Navigator.pop(context, photo);
              },
              child: Text('Camera'),
            ),
            TextButton(
              onPressed: () async {
                final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                Navigator.pop(context, photo);
              },
              child: Text('Gallery'),
            ),
          ],
        );
      },
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Raise Complaint',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Toggle between 'Private' and 'Community'
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Private'),
                  selected: selectedType == 'Private',
                  onSelected: (bool selected) {
                    setState(() {
                      selectedType = 'Private';
                    });
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Community'),
                  selected: selectedType == 'Community',
                  onSelected: (bool selected) {
                    setState(() {
                      selectedType = 'Community';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Tell us your problem?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'You can select one or more options',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Radio buttons for problem selection
            ...[
              'Dripping faucets',
              'Slow draining sink',
              'Clogged bath or shower drain',
              'Others'
            ].map((problem) => RadioListTile(
              title: Text(problem),
              value: problem,
              groupValue: selectedProblem,
              onChanged: (value) {
                setState(() {
                  selectedProblem = value.toString();
                });
              },
            )),
            const SizedBox(height: 24),
            const Text(
              'Add details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'You can write things like "2 of my taps near the kitchen door are dripping."',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            const Text(
              'Add photos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: _selectedImage == null
                      ? const Icon(Icons.add_photo_alternate, color: Colors.grey, size: 40)
                      : Image.file(
                    File(_selectedImage!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Preferred slot for resolution?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: [
                ChoiceChip(
                  label: const Text('7:00 - 11:00 AM'),
                  selected: selectedSlot == '7:00 - 11:00 AM',
                  onSelected: (selected) {
                    setState(() {
                      selectedSlot = selected ? '7:00 - 11:00 AM' : null;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('4:00 - 7:00 PM'),
                  selected: selectedSlot == '4:00 - 7:00 PM',
                  onSelected: (selected) {
                    setState(() {
                      selectedSlot = selected ? '4:00 - 7:00 PM' : null;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Checkbox(
                  value: isUrgent,
                  onChanged: (value) {
                    setState(() {
                      isUrgent = value!;
                    });
                  },
                ),
                const Text('Is the complaint urgent?'),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfirmationPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Center(
                child: Text(
                  'Submit',
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
