import 'package:flutter/material.dart';

import 'User.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser({required String id}) {
    _user = User(id: id);
    notifyListeners();
  }
}

