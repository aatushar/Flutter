import 'package:flutter/material.dart';
import 'screen/home_screen.dart'; // Assuming you created home_screen.dart for the API HomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login Form"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Image.network(
                  "https://www.zayan-tech.com/uploads/companyLogo/info-at-zayantechcom-2023-05-12-gKUFQ.png",
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 20),
                LoginForm(), // LoginForm widget for the login inputs
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _userName,
            decoration: InputDecoration(
              hintText: "User Name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_userName.text.isNotEmpty && _password.text.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmploymentHomePage()), // Navigate to API page
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please enter valid username and password"),
                ));
              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
