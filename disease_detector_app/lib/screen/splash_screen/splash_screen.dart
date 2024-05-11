import 'package:flutter/material.dart';

import '../../utils/helper/helper_function.dart';
import '../../utils/theme/custom_text_theme/custom_text_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            // SizedBox(
            //   height: 24,
            // ),
            Text("EYES DISEASES",
                style: dark
                    ? MyTextTheme.darkTextTheme.headlineLarge
                    : MyTextTheme.lightTextTheme.headlineLarge),
            Text("DETECTOR",
                style: dark
                    ? MyTextTheme.darkTextTheme.headlineLarge
                    : MyTextTheme.lightTextTheme.headlineLarge),
          ],
        ),
      ),
    );
  }
}
