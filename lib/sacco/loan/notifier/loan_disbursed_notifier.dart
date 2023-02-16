import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:saccofy/sacco/loan/models/loan_disbursement_model.dart';

class LoanDisbursedNotifier extends ChangeNotifier {
  List<DisbursedLoans> _loanDisbursedList = [];
  DisbursedLoans _currentDisbursedLoan = DisbursedLoans();

  UnmodifiableListView<DisbursedLoans> get loanDisbursedlist =>
      UnmodifiableListView(_loanDisbursedList);

  DisbursedLoans get currentDisbursedLoan => _currentDisbursedLoan;

  set loanDisbursedlist(List<DisbursedLoans> loanDisbursedList) {
    _loanDisbursedList = loanDisbursedList;
    notifyListeners();
  }

  set currentDisbursedLoan(DisbursedLoans loans) {
    _currentDisbursedLoan = loans;
    notifyListeners();
  }
}
