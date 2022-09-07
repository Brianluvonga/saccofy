import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:saccofy/sacco/loan/models/loan_request_model.dart';

class LoanNotifier with ChangeNotifier {
  List<LoanRequest> _loanRequestList = [];
  LoanRequest? _currentLoan;

  UnmodifiableListView<LoanRequest> get loanRequestlist =>
      UnmodifiableListView(_loanRequestList);

  LoanRequest get currentLoan => _currentLoan!;

  set loanRequestlist(List<LoanRequest> loanRequestlist) {
    _loanRequestList = loanRequestlist;
    notifyListeners();
  }

  set currentLoan(LoanRequest? loan) {
    _currentLoan = loan;
    notifyListeners();
  }

  addLoan(LoanRequest request) {
    _loanRequestList.insert(0, request);
    notifyListeners();
  }

  deleteloanRequest(LoanRequest request) {
    _loanRequestList
        .removeWhere((_request) => _request.memberId == request.memberId);
    notifyListeners();
  }
}
