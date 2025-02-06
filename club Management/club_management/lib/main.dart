import 'package:flutter/material.dart';
import 'package:flutterzitproject/providers/auth_provider.dart';
import 'package:flutterzitproject/route/routes.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';  // Add GetX package
import 'package:shurjopay/utilities/functions.dart';

void main() {
  initializeShurjopay(environment: "sandbox");  // Initialize ShurjoPay
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // Use GetMaterialApp instead of MaterialApp
      title: 'Flutter Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
