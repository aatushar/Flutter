// lib/services/weather_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String apiKey = 'YOUR_API_KEY';
  static const String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  final StreamController<bool> _loadingController = StreamController<bool>.broadcast();

  Stream<bool> get loadingStream => _loadingController.stream;

  Future<WeatherModel> fetchWeather(String city) async {
    _loadingController.add(true);

    final response = await http.get(Uri.parse('$apiUrl?q=$city&units=metric&appid=$apiKey'));

    _loadingController.add(false);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  void dispose() {
    _loadingController.close();
  }
}
