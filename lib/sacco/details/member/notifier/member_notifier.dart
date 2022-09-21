import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:saccofy/user/models/user_model.dart';

class MemberNotifier extends ChangeNotifier {
  UserModel? _currentMember = UserModel();
  List<UserModel> _memberList = [];

  UserModel get currentMember => _currentMember!;

  UnmodifiableListView<UserModel> get memberList =>
      UnmodifiableListView(_memberList);

  void setCurrentMember(UserModel? user) {
    _currentMember = user;
    notifyListeners();
  }

  set memberList(List<UserModel> memberList) {
    _memberList = memberList;
    notifyListeners();
  }

  set currentMember(UserModel user) {
    _currentMember = user;
    notifyListeners();
  }
}
