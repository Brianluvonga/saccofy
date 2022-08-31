import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/user/models/user_model.dart';

class SaccoNotifier extends ChangeNotifier {
  List<Sacco> _saccoList = [];
  Sacco _currentSacco = Sacco();
  List<UserModel> _saccoMembersList = [];

  UserModel _currentMember = UserModel();

  UnmodifiableListView<Sacco> get saccoList => UnmodifiableListView(_saccoList);
  UnmodifiableListView<UserModel> get memberList =>
      UnmodifiableListView(_saccoMembersList);
//get details of current sacco
  Sacco get currentSacco => _currentSacco;

  //get details of current member
  UserModel get currentMember => _currentMember;

  set saccoList(List<Sacco> saccoList) {
    _saccoList = saccoList;
    notifyListeners();
  }

  set memberList(List<UserModel> memberList) {
    _saccoMembersList = memberList;
    notifyListeners();
  }

  set currentSacco(Sacco sacco) {
    _currentSacco = sacco;
    notifyListeners();
  }

  set currentMember(UserModel member) {
    _currentMember = member;
    notifyListeners();
  }

  saveSacco(Sacco sacco) {
    _saccoList.insert(0, sacco);
    notifyListeners();
  }

  deleteSacco(Sacco sacco) {
    _saccoList.removeWhere((element) => element.saccoName == sacco.saccoName);
  }
}
