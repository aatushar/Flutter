import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../screen/login_signup.dart';

LogOut(BuildContext context) async {
  var sessionManager = SessionManager();
  await SessionManager().destroy();
  print('destroy session');
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginSignupScreen()),
  );
}