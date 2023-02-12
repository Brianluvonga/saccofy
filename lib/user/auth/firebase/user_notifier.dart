import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saccofy/user/models/user_model.dart';

class UserNotifier with ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
