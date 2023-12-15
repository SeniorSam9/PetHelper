import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser({required String id}) {
    print("Setting user with ID: $id");
    _user = User(id: id);
    print("user id here is ${_user?.id}") ;
    notifyListeners();
  }
}

class User {
  final String id;

  User({required this.id});
}