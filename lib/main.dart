import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/language_provider.dart';
import 'package:to_do_list/providers/list_provider.dart';
import 'package:to_do_list/providers/theme_provider.dart';
import 'package:to_do_list/screens/edit_task.dart';
import 'package:to_do_list/screens/home.dart';
import 'package:to_do_list/screens/splash.dart';
import 'package:to_do_list/tabs/list_tab/list_tab.dart';
import 'package:to_do_list/tabs/settings_tab/settings_tab.dart';
import 'package:to_do_list/utilities/app_theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //to make fire base offline only
  await FirebaseFirestore.instance.disableNetwork();

  LanguageProvider languageProvider = LanguageProvider();
  //shared preference
  languageProvider.setItems();

  ThemeProvider themeProvider = ThemeProvider();
  //shared preference
  themeProvider.setItems();

  ListProvider listProvider = ListProvider();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => languageProvider),
    ChangeNotifierProvider(create: (_) => themeProvider),
    ChangeNotifierProvider(create: (_) => listProvider),
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
        ListTab.routeName: (_) => ListTab(),
        SettingsTab.routeName: (_) => const SettingsTab(),
        EditTask.routeName: (_) => EditTask(),
      },
    );
  }
}
