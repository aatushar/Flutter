import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/rest_api_screen.dart';
import 'screens/third_party_api_screen.dart';
import 'screens/maps_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comprehensive App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/rest-api': (context) => RestApiScreen(),
        '/third-party-api': (context) => ThirdPartyApiScreen(),
        '/maps': (context) => MapsScreen(),
      },
    );
  }
}
