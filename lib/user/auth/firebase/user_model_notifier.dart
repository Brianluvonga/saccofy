import 'package:flutter/cupertino.dart';
import 'package:saccofy/user/models/user_model.dart';

class UserModelNotifier extends ChangeNotifier {
  UserModel? _currentUser = UserModel();

  UserModel get currentUser => _currentUser!;

  void setCurrentUser(UserModel? user) {
    _currentUser = user;
    notifyListeners();
  }
}
