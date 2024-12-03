import 'package:Checkmate/utils/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


// theme notifier to toggle the theme changes and theme related operations across the app
final themeNotifierProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier() {
    _loadTheme();
  }
  ThemeData _currentTheme = AppTheme.lightTheme;

  ThemeData get currentTheme => _currentTheme;


// initialization
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _currentTheme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (_currentTheme == AppTheme.lightTheme) {
      _currentTheme = AppTheme.darkTheme;
    } else {
      _currentTheme = AppTheme.lightTheme;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _currentTheme == AppTheme.darkTheme);
    notifyListeners();
  }
}
