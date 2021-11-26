import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const prefKey = "theme_pref_key";

  setThemePreference(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(prefKey, value);
  }

  static Future<bool> getThemePreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(prefKey) ?? false;
  }
}
