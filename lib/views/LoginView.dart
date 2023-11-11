import 'package:flutter/material.dart';

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
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.light_mode)),
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
