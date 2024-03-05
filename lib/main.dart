import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/language_provider.dart';
import 'package:to_do_list/providers/theme_provider.dart';
import 'package:to_do_list/screens/home.dart';
import 'package:to_do_list/screens/splash.dart';
import 'package:to_do_list/tabs/list_tab/list_tab.dart';
import 'package:to_do_list/tabs/settings_tab/settings_tab.dart';
import 'package:to_do_list/utilities/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LanguageProvider languageProvider = LanguageProvider();
  //shared preference
  languageProvider.setItems();

  ThemeProvider themeProvider = ThemeProvider();
  //shared preference
  themeProvider.setItems();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => languageProvider),
    ChangeNotifierProvider(create: (_) => themeProvider)
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of(context);
    ThemeProvider themeProvider = Provider.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.language),
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: themeProvider.themeMode,
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (_) => Splash(),
        Home.routeName: (_) => const Home(),
        ListTab.routeName: (_) => const ListTab(),
        SettingsTab.routeName: (_) => const SettingsTab()
      },
    );
  }
}
