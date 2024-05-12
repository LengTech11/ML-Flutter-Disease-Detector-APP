import 'package:flutter/material.dart';

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
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF35a163)),
      hintColor: const Color(0xFF35a163),
      splashColor: const Color(0xFFE8EAED),
      colorScheme: const ColorScheme(
              primary: Color(0xFF35a163),
              secondary: Color(0xFFF2F3F5),
              surface: Colors.white,
              background: Color(0xFFE3E5E8),
              error: Color(0xFFE93E36),
              onPrimary: Colors.white,
              onSecondary: Color(0xFF737E8C),
              onSurface: Colors.black,
              onBackground: Color(0xFF2E3338),
              onError: Color(0xFFE3E5E8),
              brightness: Brightness.light)
          .copyWith(background: const Color(0xFFFFFFFF)));

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFF202225),
      fontFamily: 'Poppins',
      secondaryHeaderColor: const Color(0xFF6D7177),
      inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF35a163)),
      hintColor: const Color(0xFF35a163),
      splashColor: const Color(0xFF34373C),
      colorScheme: const ColorScheme(
              primary: Color(0xFF35a163),
              secondary: Color(0xFF2F3136),
              surface: Color(0xff121212),
              background: Color(0xFF202225),
              error: Color(0xFFED4337),
              onPrimary: Colors.white,
              onSecondary: Color(0xFF72767D),
              onSurface: Colors.white,
              onBackground: Color(0xFFF8F5F9),
              onError: Color(0xFF202225),
              brightness: Brightness.dark)
          .copyWith(background: const Color(0xFF36393F)));

  // scaffoldBackgroundColor: Color(0xFF202225),
  // primaryColor: Color(0xFF35a163),
  // backgroundColor: Color(0xFF2F3136),
  // splashColor: Color(0xFF34373C),
  // colorScheme: ColorScheme.dark(),
  // iconTheme: IconThemeData(color: Color(0xFF6E7279)));
}
