import 'package:flutter/material.dart';

import 'views/LoginView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pets Helper',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.light(useMaterial3: true),
      // darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData(
        useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFF827397), brightness: Brightness.light
          ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      home: const LoginView(),
    );
  }
}
