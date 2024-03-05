import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  //shared preference
  SharedPreferences? sharedPreferences;
  static const String shPrKey = "isDark";

  void changeThemeMode(bool switchValue) {
    themeMode = switchValue ? ThemeMode.dark : ThemeMode.light;
    saveTheme(isDark);
    notifyListeners();
  }

//return true if mode is dark and false if mode is light
  bool get isDark {
    bool mode = true;
    if (themeMode == ThemeMode.light) {
      mode = false;
    }
    return mode;
  }

//shared preference functions
  Future<void> setItems() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (getTheme() ?? false) {
      changeThemeMode(getTheme()!);
    }
  }

  Future<void> saveTheme(bool isDarkParameter) async {
    await sharedPreferences!.setBool(shPrKey, isDarkParameter);
  }

  bool? getTheme() {
    return sharedPreferences!.getBool(shPrKey);
  }
}
