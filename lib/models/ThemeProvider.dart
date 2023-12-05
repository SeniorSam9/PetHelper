import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // default theme
  ThemeData _currentTheme = ThemeData.light().copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xFF827397),
      ),
      textTheme: TextTheme(
          bodyLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)));

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = (_currentTheme ==
            ThemeData.light().copyWith(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Color(0xFF827397),
                ),
                textTheme: TextTheme(
                    bodyLarge:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))))
        ? ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFF827397),
            ),
            textTheme: TextTheme(
                bodyLarge:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))
        : ThemeData.light().copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFF827397),
            ),
            textTheme: TextTheme(
                bodyLarge:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20)));
    notifyListeners();
  }
}
