import 'package:firebase_chat/themes/dark_mode.dart';
import 'package:firebase_chat/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get getTheme => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();
  }
}
