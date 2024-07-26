import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/utils/custom_text_theme/custom_text_theme.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
        backgroundColor: AppColor.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: AppColor.ok,
            ),
            const SizedBox(height: 20),
            Text(
              'Prediction saved successfully!',
              style: dark
                  ? MyTextTheme.darkTextTheme.bodyMedium
                  : MyTextTheme.lightTextTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
