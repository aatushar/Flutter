import 'package:flutter/material.dart';


class AddMemberScreen extends StatefulWidget {
  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  String selectedRole = ""; // No default selection

  Map<String, int> familyMembers = {
    "Children over": 0,
    "Children under": 0,
    "Guests": 0,
  };

  void incrementMember(String key) {
    setState(() {
      familyMembers[key] = familyMembers[key]! + 1;
    });
  }

  void decrementMember(String key) {
    if (familyMembers[key]! > 0) {
      setState(() {
        familyMembers[key] = familyMembers[key]! - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color(0xFFEFF8E9),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F3B4D),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Add Member clicked")),
                  );
                },
                child: Text('Add Member', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Add Family Members',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            RoleSelection(
              selectedRole: selectedRole,
              onRoleChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),
            SizedBox(height: 8),
            FamilyMembersSection(
              members: familyMembers,
              incrementMember: incrementMember,
              decrementMember: decrementMember,
            ),
            SizedBox(height: 16),
            Text(
              'Payment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            PaymentSection(),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F3B4D),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Payment processing...")),
                  );
                },
                child: Text('Pay Now', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class RoleSelection extends StatelessWidget {
  final String selectedRole;
  final Function(String) onRoleChanged;

  RoleSelection({required this.selectedRole, required this.onRoleChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio<String>(
              value: "Self",
              groupValue: selectedRole,
              onChanged: (value) => onRoleChanged(value!),
            ),
            Text("Self"),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: "Wife",
              groupValue: selectedRole,
              onChanged: (value) => onRoleChanged(value!),
            ),
            Text("Wife"),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: "Driver",
              groupValue: selectedRole,
              onChanged: (value) => onRoleChanged(value!),
            ),
            Text("Driver"),
          ],
        ),
      ],
    );
  }
}

class FamilyMembersSection extends StatelessWidget {
  final Map<String, int> members;
  final Function(String) incrementMember;
  final Function(String) decrementMember;

  FamilyMembersSection({required this.members, required this.incrementMember, required this.decrementMember});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: members.keys.map((key) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(key, style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(8),
                      backgroundColor: Color(0xFF1F3B4D),
                    ),
                    onPressed: () => incrementMember(key),
                    child: Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                  Container(
                    width: 40,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      members[key].toString(),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(8),
                      backgroundColor: Color(0xFF1F3B4D),
                    ),
                    onPressed: () => decrementMember(key),
                    child: Icon(Icons.remove, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class PaymentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Card Number",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: "MM/YY",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: ["01/24", "02/24", "03/24", "04/24"]
                    .map((value) => DropdownMenuItem(child: Text(value), value: value))
                    .toList(),
                onChanged: (value) {},
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "CVV",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
