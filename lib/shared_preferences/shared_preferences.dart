import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/providers/theme_provider.dart';

class MySharedPreference {
  SharedPreferences? sharedPreferences;
  static const String shPrKey = "isDark";

  Future<void> setItems(ThemeProvider themeProvider) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (getTheme() ?? false) {
      themeProvider.changeThemeMode(getTheme()!);
    }
  }

  Future<void> saveTheme(bool isDarkParameter) async {
    await sharedPreferences!.setBool(shPrKey, isDarkParameter);
  }

  bool? getTheme() {
    return sharedPreferences!.getBool(shPrKey);
  }
}
