import 'package:disease_detector_app/utils/custom_text_theme/custom_text_theme.dart';
import 'package:disease_detector_app/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class ClassProbabilities extends StatelessWidget {
  const ClassProbabilities({
    super.key,
    required this.name,
    this.confidence,
  });

  final String name;
  final double? confidence;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$name: ',
                  style: dark
                      ? MyTextTheme.darkTextTheme.titleLarge
                      : MyTextTheme.lightTextTheme.titleLarge,
                ),
                TextSpan(
                  text: '${confidence!.toStringAsFixed(2)}%',
                  style: dark
                      ? MyTextTheme.darkTextTheme.titleLarge
                      : MyTextTheme.lightTextTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 70,
          height: 70,
          child: Stack(
            children: [
              Positioned.fill(
                child: CircularProgressIndicator(
                  value: confidence! / 100,
                  backgroundColor: Colors.grey[200],
                  color: Colors.blue,
                ),
              ),
              Center(
                child: Text(
                  '${confidence!.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: dark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Colors.grey,
          height: 20,
          thickness: 2,
        ),
      ],
    );
  }
}
