import 'package:disease_detector_app/config/themes/color.dart';
import 'package:disease_detector_app/config/themes/m3_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  String? languageCode;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setKhmerLanguage() {
    languageCode = 'km';
    notifyListeners();
  }

  void setEnglishLanguage() {
    languageCode = 'en';
    notifyListeners();
  }
}

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFE3E5E8),
    fontFamily: 'Poppins',
    secondaryHeaderColor: const Color(0xFF707B89),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 15.h,
      ),
      border: InputBorder.none,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.primary,
      foregroundColor: AppColor.light,
    ),
    hintColor: AppColor.primary,
    splashColor: AppColor.light,
    iconTheme: const IconThemeData(color: AppColor.dark),
    colorScheme: M3Theme.light(),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColor.dark,
    fontFamily: 'Poppins',
    secondaryHeaderColor: AppColor.darkGrey,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 15.h,
      ),
      border: InputBorder.none,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.primary,
    ),
    hintColor: AppColor.primary,
    splashColor: AppColor.splashColor,
    iconTheme: const IconThemeData(color: AppColor.light),
    colorScheme: M3Theme.dark(),
  );
}
