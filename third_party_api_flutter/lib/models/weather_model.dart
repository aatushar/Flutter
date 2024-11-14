// lib/models/weather_model.dart
class WeatherModel {
  final String description;
  final String icon;
  final double temperature;

  WeatherModel({
    required this.description,
    required this.icon,
    required this.temperature,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temperature: json['main']['temp'].toDouble(),
    );
  }
}
