import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ThemeProvider.dart';
import 'MainView.dart';
import 'SignUpView.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          icon: Icon(
            Provider.of<ThemeProvider>(context).currentTheme ==
                    ThemeData.light()
                ? Icons.nightlight_round
                : Icons.lightbulb,
            color: const Color(0xFF827397), // Set the desired color #827397
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login Page",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainView()),
              ),
              child: Text("Log in"),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpView()),
              ),
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
