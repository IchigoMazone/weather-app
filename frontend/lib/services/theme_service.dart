
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'is_dark_mode';
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeService() {
    _loadTheme();
  }

  void toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners(); 
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDark);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }
}