import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe463_project/models/ThemeProvider.dart';
import 'package:swe463_project/models/UserProvider.dart';
import 'package:swe463_project/models/data.dart';
import 'views/LoginView.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<PetProvider>(
        create: (context) => PetProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pets Helper',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      home: const LoginView(),
    );
  }
}
