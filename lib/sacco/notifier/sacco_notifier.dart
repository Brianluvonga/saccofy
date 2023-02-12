import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/user/models/user_model.dart';

class SaccoNotifier extends ChangeNotifier {
  List<Sacco> _saccoList = [];
  Sacco _currentSacco = Sacco();

  UnmodifiableListView<Sacco> get saccoList => UnmodifiableListView(_saccoList);

//get details of current sacco
  Sacco get currentSacco => _currentSacco;

  //get details of current member

  set saccoList(List<Sacco> saccoList) {
    _saccoList = saccoList;
    notifyListeners();
  }

  set currentSacco(Sacco sacco) {
    _currentSacco = sacco;
    notifyListeners();
  }

  // saveSacco(Sacco sacco) {
  //   _saccoList.insert(0, sacco);
  //   notifyListeners();
  // }

  // deleteSacco(Sacco sacco) {
  //   _saccoList.removeWhere((element) => element.saccoName == sacco.saccoName);
  // }
}
