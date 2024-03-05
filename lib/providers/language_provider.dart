import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String language = "en";

  //shared preference
  SharedPreferences? sharedPreferences;
  static const shPrKey = "isArabic";

  void changeLanguage(String newLanguage) {
    if (newLanguage == language) {
      return;
    }
    language = newLanguage;

    //shared preference
    saveTheme(newLanguage);

    notifyListeners();
  }

  //Shared sharedPreferences functions
  String? getLanguage() {
    return sharedPreferences!.getString(shPrKey);
  }

  Future<void> setItems() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (getLanguage() == "en") {
      changeLanguage("en");
    } else {
      changeLanguage("ar");
    }
  }

  Future<void> saveTheme(String languageParameter) async {
    await sharedPreferences!.setString(shPrKey, languageParameter);
  }
}
