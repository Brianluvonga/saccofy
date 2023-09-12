import 'package:saccofy/user/models/user_model.dart';

class ApproveLoan {
  Map<String, bool> memberApprovals = {}; // store member approvals in a map

  bool isApproved = false;

  ApproveLoan();

  ApproveLoan.fromMap(Map<String, dynamic> data) {
    memberApprovals = data['memberApprovals'];
    isApproved = data['isApproved'];
  }

  Map<String, dynamic> toMap() {
    return {
      'memberApprovals': memberApprovals,
      'isApproved': isApproved,
    };
  }
}
