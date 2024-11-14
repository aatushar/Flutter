// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}
