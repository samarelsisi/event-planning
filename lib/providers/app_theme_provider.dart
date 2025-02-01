import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  // data
  ThemeMode appTheme = ThemeMode.light;

  void changeTheme() {
    if (appTheme == ThemeMode.light) {
      appTheme = ThemeMode.dark;
    } else {
      appTheme = ThemeMode.light;
    }
    notifyListeners();
  }

  void changeProfileThemes(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}
