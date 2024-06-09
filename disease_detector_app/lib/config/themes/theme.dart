import 'package:disease_detector_app/config/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppTheme {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFFE3E5E8),
      fontFamily: 'Poppins',
      secondaryHeaderColor: const Color(0xFF707B89),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primary, foregroundColor: AppColor.light),
      hintColor: AppColor.primary,
      splashColor: AppColor.light,
      iconTheme: const IconThemeData(color: AppColor.dark),
      colorScheme: const ColorScheme(
              primary: AppColor.primary,
              secondary: AppColor.lightGrey,
              surface: AppColor.white,
              error: AppColor.error,
              onPrimary: AppColor.white,
              onSecondary: AppColor.grey,
              onSurface: AppColor.black,
              onError: AppColor.light,
              brightness: Brightness.light)
          .copyWith(surface: AppColor.lightGrey));

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColor.dark,
      fontFamily: 'Poppins',
      secondaryHeaderColor: AppColor.darkGrey,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      appBarTheme: const AppBarTheme(backgroundColor: AppColor.primary),
      hintColor: AppColor.primary,
      splashColor: AppColor.splashColor,
      // iconButtonTheme: ,
      iconTheme: const IconThemeData(color: AppColor.light),
      colorScheme: const ColorScheme(
              primary: AppColor.primary,
              secondary: AppColor.secondary,
              surface: AppColor.splashColor,
              error: AppColor.error,
              onPrimary: AppColor.lightGrey,
              onSecondary: AppColor.grey,
              onSurface: AppColor.white,
              onError: AppColor.onError,
              brightness: Brightness.dark)
          .copyWith(surface: AppColor.splashColor));
}
