import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme with ChangeNotifier {
  SharedPreferences _sharedPreferences;
  static MyTheme myTheme;
  static bool _isDark = false;

  MyTheme.basic() {
    _getValue();
  }

  factory MyTheme() {
    if(myTheme == null) myTheme = MyTheme.basic();
    return myTheme;
  }

  ThemeMode currentTheme() {
    return _isDark? ThemeMode.dark : ThemeMode.light;
  }

  Icon getIcon() {
    return Icon(_isDark? Icons.brightness_3 : Icons.brightness_high);
  }

  void switchTheme() {
    _isDark = !_isDark;
    _setValue(_isDark);
    notifyListeners();
  }

  void _getValue() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _isDark = _sharedPreferences.getBool("isDark") ?? false;
    notifyListeners();
  }

  void _setValue(bool isDark) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool("isDark", isDark);
  }
}