import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeStorage {
  static Future<void> setDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', true);
  }
  static Future<void> setLightMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', false);
  }

  static Future<bool?> getThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode');
  }
}
