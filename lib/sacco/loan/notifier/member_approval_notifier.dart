import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:saccofy/sacco/loan/models/approve_loan.dart';
import 'package:saccofy/user/models/user_model.dart';

class MemberApprovalNotifier with ChangeNotifier {
  List<UserModel> _memberLoanApprovalList = [];
  UserModel _currentMember = UserModel();

  UnmodifiableListView<UserModel> get memberLoanApprovalList =>
      UnmodifiableListView(_memberLoanApprovalList);

  UserModel get currentMember => _currentMember;

  set memberLoanApprovalList(List<UserModel> memberLoanApprovalList) {
    _memberLoanApprovalList = memberLoanApprovalList;
    notifyListeners();
  }

  set currentMember(UserModel member) {
    _currentMember = member;
    notifyListeners();
  }
}
