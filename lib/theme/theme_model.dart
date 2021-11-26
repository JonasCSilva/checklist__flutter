import 'package:flutter/material.dart';
import 'theme_preference.dart';

class ThemeModel extends ChangeNotifier {
  late bool _isDark;
  late ThemePreference _preferences;

  ThemeModel(bool initialIsDark) {
    _isDark = initialIsDark;
    _preferences = ThemePreference();
  }

  bool get isDark => _isDark;

  set isDark(bool value) {
    _isDark = value;
    _preferences.setThemePreference(value);
    notifyListeners();
  }
}
