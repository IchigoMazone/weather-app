
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String _langKey = 'language_code';
  Locale _locale = const Locale('vi');

  Locale get locale => _locale;

  LanguageService() {
    _loadLanguage();
  }

  void changeLanguage(String code) async {
    _locale = Locale(code);
    notifyListeners(); 
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, code);
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_langKey) ?? 'vi';
    _locale = Locale(code);
    notifyListeners();
  }
}