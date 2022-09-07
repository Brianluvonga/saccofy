import 'package:saccofy/user/models/user_model.dart';

class LoanApprovalModel {
  UserModel? member;
  String? approveId;
  String? approvalTime;
  bool? isApproved;

  LoanApprovalModel({this.isApproved = false});

  LoanApprovalModel.fromMap(Map<String, dynamic> approve) {
    member = approve["member"];
    approveId = approve["approveId"];
    approvalTime = approve["approvalTime"];
    isApproved = approve["isApproved"];
  }
  Map<String, dynamic> toMap() {
    return {
      "member": member,
      "approveId": approveId,
      "approvalTime": approvalTime,
      "isApproved": isApproved,
    };
  }
}

class MembersLoanApprovalModel {
  List<LoanApprovalModel>? members = [];
  String? totalMembersApproval;
}
