import 'package:flutter/material.dart';

abstract class AppTheme {
  //colors
  static const whiteColor = Color(0xffffffff);
  static const blackColor = Color(0xff141922);
  static const blackLight = Color(0xff200E32);
  static const primaryBlue = Color(0xff5D9CEC);
  static const primaryLight = Color(0xffDFECDB);
  static const primaryDark = Color(0xff060E1E);

  //text style

  static const TextStyle appBareTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: whiteColor);
  static const TextStyle taskTitleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: primaryBlue);
  static const TextStyle taskDescriptionTextStyle =
      TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: blackLight);
  static const TextStyle bottomSheetTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: blackColor);

//light mode
  static ThemeData lightMode = ThemeData(
      canvasColor: whiteColor,
      primaryColor: primaryLight,
      scaffoldBackgroundColor: primaryLight,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: blackColor,
        ),
        backgroundColor: primaryBlue,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryBlue,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          selectedItemColor: primaryBlue,
          unselectedItemColor: whiteColor),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: primaryBlue),
          titleMedium: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 25, color: blackLight),
          titleSmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          )));

  //dark mode
  static ThemeData darkMode = ThemeData(
      canvasColor: primaryDark,
      primaryColor: primaryDark,
      scaffoldBackgroundColor: primaryDark,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        backgroundColor: primaryBlue,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryBlue,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          selectedItemColor: primaryBlue,
          unselectedItemColor: whiteColor),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: primaryBlue),
          titleMedium: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 25, color: blackLight),
          titleSmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          )));

//EdgeInsets for padding and margin style
  static EdgeInsets customEdgeInsets(BuildContext context) {
    return EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * 0.03,
        vertical: MediaQuery.of(context).size.width * 0.03);
  }
}
