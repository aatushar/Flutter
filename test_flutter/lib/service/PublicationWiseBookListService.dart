import 'dart:convert';

import 'package:test_flutter/model/PublicationWiseBookList.dart';
import 'package:http/http.dart' as http;

class PublicationWiseBookListService{
  final String apiUrl =
      'http://157.230.251.1:8011/api/ c/publication-wise-book-list';

  Future<List<PublicationWiseBookList>> fetchPublicationWiseBookLists() async{
    final response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode ==200 || response.statusCode ==201){
      final List<dynamic> publicationJson = jsonDecode(utf8.decode(response.bodyBytes));
      return publicationJson.map((json) => PublicationWiseBookList.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load Publication wise book list');
    }
    }
}