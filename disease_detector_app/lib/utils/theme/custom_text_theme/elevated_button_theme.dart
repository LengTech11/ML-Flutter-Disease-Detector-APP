import 'package:flutter/material.dart';

import '../../../constanst/app_color.dart';
import 'custom_text_theme.dart';
class MyElevatedBtnTheme {
  MyElevatedBtnTheme._();

  static final lightElevatedBtnTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: AppColor.white,
          backgroundColor: AppColor.primary,
          disabledForegroundColor: AppColor.grey,
          disabledBackgroundColor: AppColor.grey,
          side: const BorderSide(color: AppColor.primary),
          padding: const EdgeInsets.symmetric(vertical: 8),
          textStyle: MyTextTheme.darkTextTheme.titleLarge,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),

      ));

  static final darkElevatedBtnTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primary,
        disabledForegroundColor: AppColor.grey,
        disabledBackgroundColor: AppColor.grey,
        side: const BorderSide(color: AppColor.primary),
        padding: const EdgeInsets.symmetric(vertical: 8),
        textStyle: MyTextTheme.darkTextTheme.titleLarge,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)),

      )
  );
}
