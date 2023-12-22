// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swe463_project/features/authentication/model/UserProvider.dart';
import 'package:swe463_project/features/common/data.dart';
import 'package:swe463_project/features/common/utilities/ThemeProvider.dart';

import 'package:swe463_project/main.dart';

import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}
void main() {
  MockClient mockClient = new MockClient();
  String loginUrl='login';
  String signupUrl='signup';
  final String petUrl = 'petUrl';
  final String favUrl='favUrl';
  String userFavUrl='userFavUrl';
  List<Pet> mockPets = [
    Pet(
      id: "1",
      user_id: "1",
      title: "Cute Cat",
      image: XFile("cat.jpg"),
      city: "New York",
      lat: 40.7128,
      lng: -74.0060,
      animal_type: "Cat",
      adopted: false,
      description: "This cat is looking for a loving home.",
      contact: "contact@example.com",
      urgency: "High",
    ),
    Pet(
      id: "2",
      user_id: "2",
      title: "Friendly Dog",
      image: XFile("dog.jpg"),
      city: "Los Angeles",
      lat: 34.0522,
      lng: -118.2437,
      animal_type: "Dog",
      adopted: false,
      description: "This dog loves to play and is great with kids.",
      contact: "contact@example.com",
      urgency: "Medium",
    ),
  ];
  testWidgets("login", (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider(client: mockClient, loginUrl: loginUrl, signupUrl: signupUrl)),
          ChangeNotifierProvider<PetProvider>(
            create: (context) =>
                PetProvider(Provider.of<UserProvider>(context, listen: false),client: mockClient, petUrl: petUrl, favUrl: favUrl, userFavUrl: userFavUrl),
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    );
    when(() => mockClient.post(
      Uri.parse(loginUrl),
      body: any(named: 'body'),
      headers: any(named: 'headers'),
    )).thenAnswer((_) async {
      return http.Response(
        '{"accessToken": "mockToken", "data": "123"}',
        201,
      );
    });

    when(() => mockClient.get(
      Uri.parse(petUrl),
      headers: any(named: 'headers'),
    )).thenAnswer((_) async {
      final petList = await mockPets.map((pet) => pet.toJson()).toList();
      final Map<String, dynamic> responseData = {
        'accessToken': 'mockToken',
        'data': petList,
      };
      final response = await http.Response(jsonEncode(responseData), 201);
      return response;
    });

    when(() => mockClient.get(
      Uri.parse(favUrl+'123'),
      headers: any(named: 'headers'),
    )).thenAnswer((_) async {
      return http.Response(
        '{"accessToken": "mockToken", "data": ${mockPets[2]}}',
        201,
      );
    });


    final emailField = find.byKey(Key('loginEmailField'));
    await tester.enterText(emailField, 'email');

    final passwordField = find.byKey(Key('loginPasswordField'));
    await tester.enterText(passwordField, 'password');

    final loginButton = find.byKey(Key('loginButtonKey'));
    await tester.tap(loginButton);

    await tester.pumpAndSettle();

    // expect(find.byKey(Key('loginButtonKey')), findsNWidgets(0));

    final fab = find.byType(BottomNavigationBar);
    expect(fab, findsOneWidget);
  });


  testWidgets("signup", (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider(client: mockClient, loginUrl: loginUrl, signupUrl: signupUrl)),
          ChangeNotifierProvider<PetProvider>(
            create: (context) =>
                PetProvider(Provider.of<UserProvider>(context, listen: false)),
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    );

    await tester.tap(find.byKey(Key('GOTO_signup')));
    await tester.pumpAndSettle();


    when(() => mockClient.post(
      Uri.parse(signupUrl),
      body: any(named: 'body'),
      headers: any(named: 'headers'),
    )).thenAnswer((_) async {
      return http.Response(
        '',
        201,
      );
    });

    final nameField = find.byKey(Key('signupNameField'));
    await tester.enterText(nameField, 'name');

    final emailField = find.byKey(Key('signupEmailField'));
    await tester.enterText(emailField, 'email');

    final passwordField = find.byKey(Key('signupPasswordField'));
    await tester.enterText(passwordField, "pass");

    final passwordField2 = find.byKey(Key('signupPasswordConfirmationField'));
    await tester.enterText(passwordField2, "pass");

    await tester.drag(find.byKey(Key('signupPasswordConfirmationField')), Offset(20, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('signupButtonKey')));
    await tester.pumpAndSettle();

    final confirm = find.text('Login');
    expect(confirm, findsOneWidget);
  });
}
