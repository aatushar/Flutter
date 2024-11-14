
import 'package:api_consume/models/author.dart';
import 'package:api_consume/services/author_service.dart';
import 'package:flutter/material.dart';


class SubjectController extends ChangeNotifier {
  final ApiService apiService = ApiService();
  List<Author> authors = [];
  bool isLoading = false;
  String? errorMessage;

  SubjectController() {
    fetchAuthors();
  }

  Future<void> fetchAuthors() async {
    isLoading = true;
    notifyListeners();

    try {
      authors = await apiService.fetchAuthors();
      errorMessage = null;
    } catch (error) {
      errorMessage = 'Failed to load authors: $error';
    }

    isLoading = false;
    notifyListeners();
  }
}
