import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  const ThemePreferences(this._preferences);

  static const String _isDarkModeKey = 'isDarkMode';

  final SharedPreferences _preferences;

  ThemeMode read() {
    return _preferences.getBool(_isDarkModeKey) == true
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<bool> write(ThemeMode mode) {
    return _preferences.setBool(_isDarkModeKey, mode == ThemeMode.dark);
  }
}
