import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel with ChangeNotifier {
  SharedPreferences _sharedPreferences;
  static ThemeModel _myTheme;
  static bool _isDark = false;

  ThemeModel.primary() {
    _readTheme();
  }

  factory ThemeModel() {
    if(_myTheme == null) _myTheme = ThemeModel.primary();
    return _myTheme;
  }

  ThemeMode currentTheme() {
    return _isDark? ThemeMode.dark : ThemeMode.light;
  }

  Icon getIcon() {
    return Icon(_isDark? Icons.brightness_3 : Icons.brightness_high);
  }

  void switchTheme() {
    _isDark = !_isDark;
    _writeTheme(_isDark);
    notifyListeners();
  }

  void _readTheme() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _isDark = _sharedPreferences.getBool("isDark") ?? false;
    notifyListeners();
  }

  void _writeTheme(bool isDark) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool("isDark", isDark);
  }
}