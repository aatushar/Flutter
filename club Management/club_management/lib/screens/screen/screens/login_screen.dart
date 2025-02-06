import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class  LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FAEE), // Background color from SVG
      body: Stack(
        children: [
          // Full-Screen Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/login.svg",
              fit: BoxFit.cover,
            ),
          ),

          // Login Form Positioned Over the SVG Design
          Positioned(
            top: 200, // Adjust based on SVG layout
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.sports_golf, size: 50, color: Colors.teal), // Club Icon
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "ClubApp",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Welcome to the ClubApp. Please log in to continue.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                // Email Field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email, color: Color(0xFF264653)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 15),

                // Password Field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock, color: Color(0xFF264653)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF264653), // Button color from SVG
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),

                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text("Forgot your password?", style: TextStyle(color: Colors.black54)),
                ),
                // Register Link
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text(
                    "Don't have an account? Register",
                    style: TextStyle(color: Color(0xFF264653)),
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
