
import 'package:flutter/material.dart';

import '../constanst/app_color.dart';
import '../utils/theme/custom_text_theme/custom_text_theme.dart';

class MyTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final bool dark;
  const MyTextFormField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.keyBoardType,
      required this.textInputAction,
      required this.dark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: dark ? AppColor.darkGrey : AppColor.lightGrey,
      ),
      child: TextFormField(
        keyboardType: keyBoardType,
        textInputAction: textInputAction,
        maxLines: 1,
        cursorColor: AppColor.primary,
        controller: controller,
        style: dark
            ? MyTextTheme.darkTextTheme.titleMedium
            : MyTextTheme.lightTextTheme.titleMedium,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: dark
              ? MyTextTheme.darkTextTheme.labelMedium
              : MyTextTheme.lightTextTheme.labelMedium,
          // fillColor: AppColor.black,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter email';
          }
          return null;
        },
        onSaved: (value) {},
      ),
    );
  }
}
