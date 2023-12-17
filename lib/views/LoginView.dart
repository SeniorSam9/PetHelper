import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:swe463_project/models/UserProvider.dart';
import 'package:swe463_project/views/MainView.dart';
import '../models/ThemeProvider.dart';
import '../models/data.dart';
import './SignUpView.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late bool _passwordHidden = true;
  @override
  void initState() {
    super.initState();
  }

  // a key that discriminate login form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers to manipulate form data
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> submitLoginForm() async {
    final Map<String, dynamic> loginData = {
      'email': _emailController.text,
      'password': _passwordController.text
    };

    try {
      // sending request
      final response = await http.post(
          Uri.parse("http://localhost:3300/auth/login"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(loginData));
      if (response.statusCode == 201) {
        // successful response
        final jsonRes = jsonDecode(response.body);
        print("json results are :  $jsonRes");
        Provider.of<UserProvider>(context, listen: false)
            .setUser(id: jsonRes['data']);
        print('Login successful: $jsonRes');
        return true;
      } else {
        // Failed login, handle the error
        print('Failed to login. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color #827397
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          icon: Icon(
            Provider.of<ThemeProvider>(context).currentTheme ==
                    ThemeProvider().currentTheme
                ? Icons.nightlight_round
                : Icons.sunny,
            color: const Color(0xFF827397), // Set the desired color #827397
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "PetHelper",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/loginIcon1.svg',
                        width: 50,
                        height: 50,
                        color: const Color(0xFF827397),
                      ),
                      SvgPicture.asset(
                        'assets/images/loginIcon2.svg',
                        width: 50,
                        height: 50,
                        color: const Color(0xFF827397),
                      ),
                      SvgPicture.asset(
                        'assets/images/loginIcon3.svg',
                        width: 50,
                        height: 50,
                        color: const Color(0xFF827397),
                      ),
                      SvgPicture.asset(
                        'assets/images/loginIcon4.svg',
                        width: 50,
                        height: 50,
                        color: const Color(0xFF827397),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        validator: (value) {
                          // not much of a validaiton is done here
                          // we will be using firebase to login
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.email_outlined),
                          label: const Text('Email'),
                          hintText: 'Enter your email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid password";
                          }
                          return null;
                        },
                        obscureText: _passwordHidden,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            child: Icon(_passwordHidden
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onTap: () {
                              setState(() {
                                _passwordHidden = !_passwordHidden;
                              });
                            },
                          ),
                          label: const Text('Password'),
                          hintText: 'Enter your password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      // Implement your login logic here
                      // backend not tested yet
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Loading...')),
                        );
                        if (await submitLoginForm()) {

                          await Provider.of<PetProvider>(context, listen: false)
                              .fetchAndSetPets();
                          await Provider.of<PetProvider>(context, listen: false).fetchAndSetFavoritePets();


                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MainView()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Error has occured, please try again.')),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                          );
                        }
                      }
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the signup screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpView()),
                      );
                    },
                    child: Text(
                      'Don\'t have an account? SignUp here.',
                      style: TextStyle(
                        color: const Color(0xFF827397),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
