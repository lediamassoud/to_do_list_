import 'package:flutter/material.dart';
import 'package:to_do_list/utilities/image_path.dart';

import 'home.dart';

class Splash extends StatelessWidget {
  static const routeName = "splash";

  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Home.routeName);
    });
    return Image(image: AssetImage(ImagesPathes.splashLight));
  }
}
