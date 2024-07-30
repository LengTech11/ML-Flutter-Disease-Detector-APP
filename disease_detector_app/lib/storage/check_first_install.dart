import 'package:shared_preferences/shared_preferences.dart';

class CheckFirstInstall {
  static Future<void> setFirstInstall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstInstall', false);
  }

  static Future<bool?> getFirstInstall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstInstall');
  }
}
