import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/subject.dart';

class ApiService {
  final String apiUrl = "http://157.230.251.1:8011/api/website/subject-list";

  Future<List<Subject>> fetchSubjects() async {
    final response = await http.get(Uri.parse(apiUrl)).timeout(Duration(seconds: 10));


    if (response.statusCode == 200) {
      // Decode JSON data into a List of dynamic items
      List<dynamic> jsonData = json.decode(response.body);

      // Map each item in the list to a Subject instance
      return jsonData.map((jsonItem) => Subject.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load subjects');
    }
  }
}
