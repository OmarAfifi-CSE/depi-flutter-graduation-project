import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider(ThemeMode initialThemeMode) {
    _loadTheme();
  }

static const String themeKey = 'themeMode';

  void setTheme(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', mode.toString());
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeText = prefs.getString('themeMode');
    if (themeText != null) {
      if (themeText.contains('dark')) {
        _themeMode = ThemeMode.dark;
      } else if (themeText.contains('light')) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.system;
      }
    }
    notifyListeners();
  }
}
