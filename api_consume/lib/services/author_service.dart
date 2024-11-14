// api_service.dart
import 'dart:convert';
import 'package:api_consume/models/author.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String apiUrl = "http://157.230.251.1:8011/api/website/author-wise-book-list";

  Future<List<Author>> fetchAuthors() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Decode the response body with UTF-8
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((json) => Author.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load authors');
    }
  }
}
