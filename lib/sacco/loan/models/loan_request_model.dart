import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';

class LoanRequest {
  String? id;
  String? memberId;
  String? loanAmount;
  String? loanPurpose;
  String? interestRate;
  String? status;
  String? dateOfRequest;
  String? dateOfRepayment;

  LoanRequest(
      {this.id,
      this.memberId,
      this.loanAmount,
      this.loanPurpose,
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
      "interestRate": interestRate,
      "status": status,
      "dateOfRequest": dateOfRequest,
      "dateOfRepayment": dateOfRepayment,
    };
  }
}
