// class to aid disburseFunds to the memmber who applied for the loan
import 'package:saccofy/sacco/loan/models/loan_request_model.dart';
import 'package:saccofy/user/models/user_model.dart';

class DisbursedLoans {
  UserModel? user; // fetch the user with whom the loan is given
  LoanRequest? loan; // get the loan request
  String? dateOfDisbursement; // date of loan disburse

  DisbursedLoans({this.user, this.loan, this.dateOfDisbursement});

  factory DisbursedLoans.fromMap(Map<String, dynamic> data) {
    return DisbursedLoans(
      user: data['user'],
      loan: data['loan'],
      dateOfDisbursement: data['dateOfDisbursement'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'loan': loan,
      'dateOfDisbursement': dateOfDisbursement,
    };
  }
}
