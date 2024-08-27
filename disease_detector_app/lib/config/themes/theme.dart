
import 'package:disease_detector_app/config/themes/m3_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
    scaffoldBackgroundColor: M3Theme.light().surface,
    fontFamily: GoogleFonts.khmer().fontFamily,
    secondaryHeaderColor: M3Theme.light().onSecondary,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 15.h,
      ),
      border: InputBorder.none,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: M3Theme.light().primaryContainer,
      foregroundColor: M3Theme.light().onPrimaryContainer,
    ),
    hintColor: M3Theme.light().primaryContainer,
    splashColor: M3Theme.light().surface,
    iconTheme: IconThemeData(
      color: M3Theme.light().onPrimaryContainer,
    ),
    colorScheme: M3Theme.light(),
    textTheme: GoogleFonts.khmerTextTheme(),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: M3Theme.dark().surface,
    fontFamily: GoogleFonts.khmer().fontFamily,
    secondaryHeaderColor: M3Theme.dark().onSecondary,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 15.h,
      ),
      border: InputBorder.none,
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: M3Theme.dark().primaryContainer,
      foregroundColor: M3Theme.dark().onPrimaryContainer,
    ),
    hintColor: M3Theme.dark().primaryContainer,
    splashColor: M3Theme.dark().surface,
    iconTheme: IconThemeData(
      color: M3Theme.dark().onPrimaryContainer,
    ),
    colorScheme: M3Theme.dark(),
    textTheme: GoogleFonts.khmerTextTheme(),
  );
}
