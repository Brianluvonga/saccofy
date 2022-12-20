import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saccofy/user/models/user_model.dart';

class AuthNotifier with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  set currentUserLoggedIn(UserModel? user) {
    _user = user as User?;
    notifyListeners();
  }
}
