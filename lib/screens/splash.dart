import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/theme_provider.dart';
import 'package:to_do_list/screens/auth/login/login.dart';
import 'package:to_do_list/utilities/image_path.dart';

class Splash extends StatelessWidget {
  static const routeName = "splash";

  Splash({super.key});

  late ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of(context);

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Login.routeName);
    });
    return Image(
        image: AssetImage(themeProvider.isDark
            ? ImagesPathes.splashDark
            : ImagesPathes.splashLight));
  }
}
