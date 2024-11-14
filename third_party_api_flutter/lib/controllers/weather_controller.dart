// lib/controllers/weather_controller.dart
import 'package:get/get.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherController extends GetxController {
  var isLoading = true.obs;
  var weather = WeatherModel(description: '', icon: '', temperature: 0.0).obs;
  var errorMessage = ''.obs;

  void fetchWeather(String city) async {
    try {
      isLoading(true);
      errorMessage('');
      var weatherData = await WeatherService().fetchWeather(city);
      weather(weatherData);
    } catch (e) {
      errorMessage(e.toString());
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
