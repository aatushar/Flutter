// lib/screens/weather_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        color: Colors.blueGrey[50],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter city',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                weatherController.fetchWeather(value);
              },
            ),
            SizedBox(height: 20),
            Obx(() {
              if (weatherController.isLoading.value) {
                return CircularProgressIndicator();
              } else if (weatherController.errorMessage.isNotEmpty) {
                return Text(
                  'Error: ${weatherController.errorMessage}',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                );
              } else {
                return Column(
                  children: [
                    Text(
                      weatherController.weather.value.description,
                      style: TextStyle(fontSize: 24, color: Colors.black87),
                    ),
                    Image.network(
                      'http://openweathermap.org/img/wn/${weatherController.weather.value.icon}.png',
                      scale: 1.0,
                    ),
                    Text(
                      '${weatherController.weather.value.temperature} °C',
                      style: TextStyle(fontSize: 24, color: Colors.black87),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
