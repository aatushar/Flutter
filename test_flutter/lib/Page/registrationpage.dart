

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController cell = TextEditingController();
  final TextEditingController address = TextEditingController();

  String? selectedGender;
  final _formKey = GlobalKey<FormState>();

  void _register() {
    if (_formKey.currentState!.validate()) {
      String userName = name.text;
      String userEmail = email.text;
      String userPassword = password.text;

      print('Name: $userName, Email: $userEmail, Password: $userPassword');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Adjust padding dynamically based on screen size
    double paddingValue = screenWidth * 0.05;
    double textFieldHeight = screenHeight * 0.08;

    return Scaffold(
        appBar: AppBar(
          title: Text("Registration"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(paddingValue),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Name Field
                    SizedBox(
                      height: textFieldHeight,
                      child: TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    // Email Field
                    SizedBox(
                      height: textFieldHeight,
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    // Password Field
                    SizedBox(
                      height: textFieldHeight,
                      child: TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    // Confirm Password Field
                    SizedBox(
                      height: textFieldHeight,
                      child: TextFormField(
                        controller: confirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value != password.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    // Cell Number Field
                    SizedBox(
                      height: textFieldHeight,
                      child: TextFormField(
                        controller: cell,
                        decoration: InputDecoration(
                          labelText: 'Cell Number',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    // Address Field
                    SizedBox(
                      height: textFieldHeight,
                      child: TextFormField(
                        controller: address,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.home),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    // Date of Birth Field
                    SizedBox(
                      height: textFieldHeight,
                      child: DateTimeFormField(
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        onDateSelected: (DateTime value) {
                          print('Selected date: $value');
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    // Gender Selection
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender:',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10), // Adds spacing between the label and radio buttons
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio<String>(
                                    value: 'Male',
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                  ),
                                  Text('Male'),
                                  SizedBox(width: 20),
                                  Radio<String>(
                                    value: 'Female',
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                  ),
                                  Text('Female'),
                                  SizedBox(width: 20),
                                  Radio<String>(
                                    value: 'Other',
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value;
                                      });
                                    },
                                  ),
                                  Text('Other'),
                                ],
                              ),
                            ],
                          ),



                          // Registration Button
                          Center(
                            child: SizedBox(
                              width: screenWidth,
                              height:
                            screenHeight * 0.07,
                            child: ElevatedButton(
                              onPressed: _register,
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize:20 ,
                                  fontFamily: GoogleFonts.lato().fontFamily,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green, // Use backgroundColor instead of primary
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                )// Use foregroundColor instead of onPrimary
                              ),
                            ),
                          ),
                          ),
                        ],

                      ),
                    ),
                  ]
              ),
            )
        )
    );
  }
}
