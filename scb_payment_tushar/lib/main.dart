import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:scb_payment_tushar/screen/bill/4N_03_shop_wise_demand_charge.dart';

import 'package:scb_payment_tushar/screen/custom_animation.dart';
import 'package:scb_payment_tushar/screen/home.dart';
import 'package:scb_payment_tushar/screen/login_signup.dart';
import 'package:shurjopay/utilities/functions.dart';

import 'config/palette.dart';


Future<void> main() async {
  initializeShurjopay(environment: "live");
  WidgetsFlutterBinding.ensureInitialized();
  var userID = await SessionManager().get("userID");
  runApp((userID != null) ? HomeDashboard() : LoginSignupUI());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 500)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Palette.primaryBG
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class LoginSignupUI extends StatefulWidget {
  const LoginSignupUI({super.key});

  @override
  State<LoginSignupUI> createState() => _LoginSignupUIState();
}

class _LoginSignupUIState extends State<LoginSignupUI> {
  Timer? _timer;
  late double _progress;

  @override
  void initState(){
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login Signup UI",
      theme: ThemeData(
        primaryColor: Palette.primaryBG,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginSignupScreen(),
      builder: EasyLoading.init(),
    );
  }
}


class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  Timer? _timer;
  late double _progress;

  @override
  void initState(){
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if(status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    // EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login Signup UI",
      theme: ThemeData(
        primaryColor: Palette.primaryBG,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ShopWiseDemandCharge(),
      builder: EasyLoading.init(),
    );
  }
}
