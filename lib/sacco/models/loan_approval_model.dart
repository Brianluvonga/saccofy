import 'package:saccofy/user/models/user_model.dart';

class LoanApprovalModel {
  UserModel? member;
  String? id;
  String? approvalTime;
  bool? is_approved;

  LoanApprovalModel();
}

class MembersLoanApprovalModel {
  List<LoanApprovalModel>? members = [];
  String? totalMembersApproval;
}
