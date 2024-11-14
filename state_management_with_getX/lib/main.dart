// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/counter_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // Initialize the CounterController using Get.put() to make it available globally
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Counter App'),
      ),
      body: Center(
        child: Obx(() {
          return Text(
            'Counter: ${counterController.counter}',
            style: TextStyle(fontSize: 30),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterController.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
