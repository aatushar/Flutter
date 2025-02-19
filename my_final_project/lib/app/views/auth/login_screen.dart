import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FAEE),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/login.svg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 200,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.sports_golf, size: 50, color: Colors.teal),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "ClubApp",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Welcome to ClubApp. Please log in to continue.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 20),

                // Email or Phone Field
                TextField(
                  controller: emailOrPhoneController,
                  decoration: InputDecoration(
                    labelText: "Email or Phone Number",
                    prefixIcon: const Icon(Icons.person, color: Color(0xFF264653)),
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
                Obx(() {
                  return ElevatedButton(
                    onPressed: () => loginController.login(
                      emailOrPhoneController.text.trim(),
                      passwordController.text.trim(),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF264653),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: loginController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
                  );
                }),

                const SizedBox(height: 10),

                // Forgot Password
                TextButton(
                  onPressed: () => loginController.forgotPassword(emailOrPhoneController.text.trim()),
                  child: const Text("Forgot your password?", style: TextStyle(color: Colors.black54)),
                ),

                // Register Link
                TextButton(
                  onPressed: () => Get.toNamed('/register'),
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
