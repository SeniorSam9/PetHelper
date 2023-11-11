import 'package:flutter/material.dart';

import 'MainView.dart';
import 'LoginView.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Signup Page",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainView()),
              ),
              child: Text("Sign Up"),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              ),
              child: Text("Log In"),
            ),
          ],
        ),
      ),
    );
  }
}
