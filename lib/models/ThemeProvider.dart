import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static ColorScheme _colorScheme = ColorScheme.fromSeed(seedColor: Color(0xFF827397));

  static final ThemeData _lightTheme = ThemeData.light().copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Color(0xFF827397),
      ),
      primaryColor: Color(0xFF827397),
      textTheme: TextTheme(
          headlineLarge: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Color(0XFF5F5B5B)),
          bodyLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0XFF5F5B5B)),
          bodyMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0XFFCCCCCC)),
          bodySmall: TextStyle(fontWeight: FontWeight.w200, fontSize: 16, color: Color(0XFFCCCCCC)),
        labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
        labelSmall: TextStyle(fontSize: 12, color: Color(0XFF9D9D9D)),

      ),


      scaffoldBackgroundColor: Color(0XFFFFFFFF),
      appBarTheme: AppBarTheme(color: Colors.transparent),
      navigationBarTheme: NavigationBarThemeData(backgroundColor: Colors.transparent),
      buttonTheme: ButtonThemeData(colorScheme: ThemeProvider._colorScheme),
    // textButtonTheme:
  );

  static final ThemeData _darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Color(0xFF827397),
    ),
      primaryColor: Color(0xFF827397),
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Color(0XFFD9D9D9)),
      bodyLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0XFFD9D9D9)),
      bodyMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0XFF222222)),
      bodySmall: TextStyle(fontWeight: FontWeight.w200, fontSize: 16, color: Color(0xFF222222)),
      labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
      labelSmall: TextStyle(fontSize: 12, color: Color(0XFF9D9D9D)),
    ),

    scaffoldBackgroundColor: Color(0XFF252831),
    appBarTheme: AppBarTheme(color: Colors.transparent),
    navigationBarTheme: NavigationBarThemeData(backgroundColor: Colors.transparent),
    buttonTheme: ButtonThemeData(colorScheme: ThemeProvider._colorScheme)
    // textButtonTheme:

  );

  ThemeData _currentTheme = _lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = (_currentTheme == _lightTheme) ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}
