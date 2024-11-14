import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../services/api_service.dart';

class SubjectController extends ChangeNotifier {
  List<Subject> subjects = [];
  bool isLoading = true;
  String errorMessage = '';

  final ApiService _apiService = ApiService();

  SubjectController() {
    fetchSubjects();
  }

  void fetchSubjects() async {
    try {
      isLoading = true;
      notifyListeners();

      subjects = await _apiService.fetchSubjects();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = 'Error fetching data';
      notifyListeners();
    }
  }
}
