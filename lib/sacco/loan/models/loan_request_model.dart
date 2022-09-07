import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';

class LoanRequest extends Sacco {
  String? memberId;
  String? amount;
  String? loanPurpose;
  String? loanType;
  int? interestRate;
  Timestamp? dateOfRequest;
  Timestamp? dateOfRepayment;

  LoanRequest(
      {this.memberId, this.amount, this.dateOfRequest, this.dateOfRepayment});

  LoanRequest.fromMap(Map<String, String> request) {
    memberId = request["memberId"];
    amount = request["amount"];
    loanPurpose = request["loanPurpose"];
    loanType = request["loanType"];
    interestRate = request["interestRate"] as int?;
    dateOfRequest = request["dateOfRequest"] as Timestamp?;
    dateOfRepayment = request["dateOfRepayment"] as Timestamp;
  }

  Map<String, dynamic> toMap() {
    return {
      "memberId": memberId,
      "amount": amount,
      "loanPurpose": loanPurpose,
      "loanType": loanType,
      "interestRate": interestRate,
      "dateOfRequest": dateOfRequest,
      "dateOfRepayment": dateOfRepayment,
      "saccoId": saccoId,
    };
  }
}
