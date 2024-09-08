import 'package:disease_detector_app/storage/theme_mode_storage.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode? themeMode;
  bool isDarkModeOn = false;

  String? languageCode;

  Future<void> getThemeMode() async {
    isDarkModeOn = await ThemeModeStorage.getThemeMode() ?? false;
    if (isDarkModeOn) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    if (isOn) {
      ThemeModeStorage.setDarkMode();
    } else {
      ThemeModeStorage.setLightMode();
    }
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
