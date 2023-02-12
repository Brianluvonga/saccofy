import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:saccofy/sacco/deposit/model/member_contributions.dart';

class DepositNotifier with ChangeNotifier {
  List<Deposit> depositList = []; // list of deposits made by members
  Deposit currentDeposit = Deposit(); //view current deposit

  UnmodifiableListView<Deposit> get getDepositList =>
      UnmodifiableListView(depositList);

  //get details of current sacco
  Deposit get getCurrentDeposit => currentDeposit;

  set getDepositList(List<Deposit> getDepositList) {
    depositList = getDepositList;
    notifyListeners();
  }

  set getCurrentDeposit(Deposit deposit) {
    currentDeposit = deposit;
    notifyListeners();
  }
}
