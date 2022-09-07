import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saccofy/payment/models/deposit_funds_model.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/sacco/models/loan_approval_model.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

CollectionReference funds = FirebaseFirestore.instance.collection('sacco');

requestLoanFromSaccoMembers(AuthNotifier loanee, Sacco sacco) {
  //request for a loan send to members in the sacco
}

depositFundsToSacco(
    DepositFundsToSacco deposit, String? paymentType, String? userId) async {
  var ans = funds.doc(userId).collection('collection');

  //make request to payment server

  //request granted

  // deposit and update details to firebase collection
  List<String>? memberDeposits = [];
}

withdrawAmountFromSacco(UserModel member, String payment) {
  //make request to payment server

  //request granted

  //
}

getAmountMemberRequests(String? amount) {}

sendLoanFundsToMember(UserModel member, String payment) {
  //after members approve

  //funds send to memmber
}

//fetch the percentage of members who approved

getMemberApprovalPercentage(
    MembersLoanApprovalModel? members, LoanApprovalModel member) {
  int? totalMembers = members!.members!.length;
  int? percentage = 100;
  int? countMemberApprovalStatus = 0;
  // ignore: unnecessary_null_comparison
  if (members == null) {
    return;
  } else if (member.isApproved = true) {
    countMemberApprovalStatus = countMemberApprovalStatus + 1;
    var ans = countMemberApprovalStatus * percentage;
    var solution = ans / totalMembers;

    return solution;
  }
}
