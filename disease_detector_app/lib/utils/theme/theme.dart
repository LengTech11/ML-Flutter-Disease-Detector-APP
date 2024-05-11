import 'package:flutter/material.dart';

import '../../constanst/app_color.dart';
import 'custom_text_theme/custom_text_theme.dart';

class MyTheme {
  MyTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.white,
    textTheme: MyTextTheme.lightTextTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.dark,
    textTheme: MyTextTheme.darkTextTheme,
  );
}
