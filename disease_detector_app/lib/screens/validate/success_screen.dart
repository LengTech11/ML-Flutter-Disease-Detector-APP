import 'package:flutter/material.dart';
import 'package:disease_detector_app/config/themes/color.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
        backgroundColor: AppColor.primary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: AppColor.ok,
            ),
            SizedBox(height: 20),
            Text(
              'Prediction saved successfully!',
            ),
          ],
        ),
      ),
    );
  }
}
