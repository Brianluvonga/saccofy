import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:saccofy/user/models/user_model.dart';

class UserModelNotifier with ChangeNotifier {
  UserModel _currentUser = UserModel();
  List<UserModel> _userList = [];

  UserModel get currentUser => _currentUser;

  UnmodifiableListView<UserModel> get userList =>
      UnmodifiableListView(_userList);

  void setCurrentUser(UserModel? user) {
    _currentUser = user!;
    notifyListeners();
  }

  set userList(List<UserModel> userList) {
    _userList = userList;
    notifyListeners();
  }

  set currentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
}
