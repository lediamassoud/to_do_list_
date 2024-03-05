import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String language = "en";

  void changeLanguage(String newLanguage) {
    if (newLanguage == language) {
      return;
    }
    language = newLanguage;
    notifyListeners();
  }
}
