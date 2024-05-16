
import 'package:disease_detector_app/config/themes/app_size.dart';
import 'package:flutter/material.dart';

import '../config/themes/color.dart';

class MyButton extends StatelessWidget {
  final String name;
  final bool dark;
  const MyButton({super.key, required this.dark, required this.name});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: dark ? AppColor.primary : AppColor.primary),
      child: Text(
        name,
        style: dark
            ? TextStyle(fontSize: AppSize.fontLg, fontWeight: FontWeight.w500, color: AppColor.white)
            : TextStyle(fontSize: AppSize.fontLg, fontWeight: FontWeight.w500, color: AppColor.white),
      ),
    );
  }
}
