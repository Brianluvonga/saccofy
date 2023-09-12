import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:saccofy/sacco/loan/models/loan_request_model.dart';

class LoanRequestNotifier with ChangeNotifier {
  List<LoanRequest> _loanRequestList = [];
  LoanRequest _currentLoan = LoanRequest();

  UnmodifiableListView<LoanRequest> get loanRequestlist =>
      UnmodifiableListView(_loanRequestList);

  LoanRequest get currentLoan => _currentLoan;

  set loanRequestlist(List<LoanRequest> loanRequestlist) {
    _loanRequestList = loanRequestlist;
    notifyListeners();
  }

  set currentLoan(LoanRequest loan) {
    _currentLoan = loan;
    notifyListeners();
  }
}
