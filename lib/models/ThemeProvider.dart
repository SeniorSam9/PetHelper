import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static final ThemeData _lightTheme = ThemeData.light().copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF827397),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  );

  static final ThemeData _darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF827397),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
  );

  ThemeData _currentTheme = _lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = (_currentTheme == _lightTheme) ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}
