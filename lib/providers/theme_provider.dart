import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void changeThemeMode(bool switchValue) {
    themeMode = switchValue ? ThemeMode.dark : ThemeMode.light;

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
}
