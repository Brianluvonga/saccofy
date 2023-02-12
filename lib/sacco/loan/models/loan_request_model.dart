import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';

class LoanRequest extends Sacco {
  String? id;
  String? memberId;
  double? loanAmount;
  String? loanPurpose;
  String? loanType;
  int? interestRate;
  String? status;
  Timestamp? dateOfRequest;
  Timestamp? dateOfRepayment;

  LoanRequest(
      {this.id,
      this.memberId,
      this.loanAmount,
      this.loanPurpose,
      this.loanType,
      this.interestRate,
      this.status = 'pending',
      this.dateOfRequest,
      this.dateOfRepayment});

  factory LoanRequest.fromMap(Map<String, dynamic> data) {
    return LoanRequest(
      id: data['id'],
      memberId: data['memberId'],
      loanAmount: data['loanAmount'],
      loanPurpose: data['loanPurpose'],
      loanType: data['loanType'],
      status: data['status'],
      interestRate: data['interestRate'],
      dateOfRequest: data['dateOfRequest'],
      dateOfRepayment: data['dateOfRepayment'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "memberId": memberId,
      "loanAmount": loanAmount,
      "loanPurpose": loanPurpose,
      "loanType": loanType,
      "interestRate": interestRate,
      "status": status,
      "dateOfRequest": dateOfRequest,
      "dateOfRepayment": dateOfRepayment,
      "saccoId": saccoId,
    };
  }
}
