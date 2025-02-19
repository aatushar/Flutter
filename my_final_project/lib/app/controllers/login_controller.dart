import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  // 🔐 Login with Email or Phone
  Future<void> login(String input, String password) async {
    if (input.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    isLoading.value = true;

    try {
      if (input.contains("@")) {
        // Email login
        await _auth.signInWithEmailAndPassword(email: input, password: password);
      } else {
        // Phone login requires OTP verification (handled separately)
        await _auth.verifyPhoneNumber(
          phoneNumber: input,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
            Get.offAllNamed('/home');
          },
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar("Error", e.message ?? "Phone Verification Failed");
          },
          codeSent: (String verificationId, int? resendToken) {
            Get.toNamed('/otp', arguments: verificationId);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // 🔐 Forgot Password
  Future<void> forgotPassword(String email) async {
    if (!email.contains("@")) {
      Get.snackbar("Error", "Enter a valid email to reset password");
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset link sent to your email");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
