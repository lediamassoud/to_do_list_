import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_list/screens/home.dart';
import 'package:to_do_list/screens/splash.dart';
import 'package:to_do_list/tabs/list_tab.dart';
import 'package:to_do_list/tabs/settings_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (_) => const Splash(),
        Home.routeName: (_) => const Home(),
        ListTab.routeName: (_) => const ListTab(),
        SettingsTab.routeName: (_) => const SettingsTab()
      },
    );
  }
}
