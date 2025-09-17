import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  // A constant key to use for saving/loading the theme.
  static const String _themeKey = 'theme_mode';
  static String get themeKey => _themeKey;
  ThemeMode _themeMode;

  ThemeProvider(this._themeMode);
  ThemeMode get themeMode => _themeMode;

  Future<void> setTheme(ThemeMode themeMode) async {
    if (_themeMode == themeMode) return;
    _themeMode = themeMode;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, themeMode.name);
    } catch (e) {
      debugPrint("Error saving theme: $e");
    }
  }
}