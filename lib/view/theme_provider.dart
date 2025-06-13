import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  bool isDarkMode = false;

  bool getThemeValue() => isDarkMode;

  void updateTheme({required bool value}){
    isDarkMode = value;
    notifyListeners();
  }
}