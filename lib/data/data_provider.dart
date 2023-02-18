import 'package:find_my_subway/theme.dart';
import 'package:flutter/material.dart';

class ThemeColor with ChangeNotifier
{
  ThemeColors themeDatas = new ThemeColors();
  ThemeMode themeNotifier = ThemeMode.dark;
  void changeTheme() {
    if(themeNotifier == ThemeMode.dark) {
      themeNotifier = ThemeMode.light;
    }
    else
      {
        themeNotifier = ThemeMode.dark;
      }
    notifyListeners();
  }
}