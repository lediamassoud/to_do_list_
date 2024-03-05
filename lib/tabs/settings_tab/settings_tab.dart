import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/extention_function/extention_function_l10n.dart';

import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utilities/app_theme.dart';

class SettingsTab extends StatefulWidget {
  static const String routeName = "settings";

  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late LanguageProvider languageProvider;
  late ThemeProvider themeProvider;
  String selectedLanguage = "en";
  bool themeMode = false; // dark mode
  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of<LanguageProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          child: Text(
            context.l10n.language,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
            padding: AppTheme.customEdgeInsets(context),
            margin: AppTheme.customEdgeInsets(context),
            decoration: const BoxDecoration(
              color: AppTheme.whiteColor,
            ),
            child: buildLanguageDropDownButton()),
        Container(
            padding: AppTheme.customEdgeInsets(context),
            margin: AppTheme.customEdgeInsets(context),
            decoration: const BoxDecoration(
              color: AppTheme.whiteColor,
            ),
            child: buildThemeSwitch()),
      ],
    );
  }

  //language logic
  Widget buildLanguageDropDownButton() {
    return DropdownButton<String>(
        value: languageProvider.language,
        items: [
          DropdownMenuItem(value: "en", child: Text(context.l10n.english)),
          DropdownMenuItem(value: "ar", child: Text(context.l10n.arabic))
        ],
        isExpanded: true,
        onChanged: (newLanguage) {
          languageProvider.changeLanguage(newLanguage!);
          setState(() {});
        });
  }

  //theme logic
  Widget buildThemeSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          themeProvider.isDark ? context.l10n.light : context.l10n.dark,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Switch(
            value: themeProvider.isDark,
            onChanged: (newValue) {
              themeProvider.changeThemeMode(newValue);
            },
            activeTrackColor: themeProvider.isDark
                ? AppTheme.primaryLight
                : AppTheme.blackColor,
            activeColor: themeProvider.isDark
                ? AppTheme.primaryLight
                : AppTheme.blackColor),
      ],
    );
  }
}
