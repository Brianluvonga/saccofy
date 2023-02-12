import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:saccofy/payment/models/deposit_funds_model.dart';
import 'package:saccofy/payment/mpesa/functions/mpesa.dart';
import 'package:saccofy/sacco/loan/models/loan_disbursement_model.dart';
import 'package:saccofy/sacco/loan/models/loan_request_model.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/sacco/models/loan_approval_model.dart';

//class DepositFundsModel
class PaymentFunctions extends LoanApprovalModel {
  // collection reference to the sacco deposits

  CollectionReference saccoDeposits =
      FirebaseFirestore.instance.collection('sacco');
  //
  //
  //function to deposit funds to sacco

  depositFundsToSacco(String memberId, String saccoId, int amount) {
    var depositReference = saccoDeposits.doc(saccoId).collection('deposits');

    try {} catch (e) {}
  }

  // function to update funds deposited to the sacco

  updateSaccoFunds(String? saccoId, int? amount, String? memberId) async {
    var depositReference = saccoDeposits.doc(saccoId).collection('deposits');

    try {} catch (e) {}
  }

  //function to request a loan from the sacco member belongs to

  requestLoan(
      String memberId, LoanRequest request, Function loanRequest) async {
    String? requestMessage = "Invalid loan request";
    var loanReference = FirebaseFirestore.instance
        .collection('sacco')
        .doc(memberId)
        .collection('loan requests');
    try {
      await loanReference.add(request.toMap());
      DocumentReference loanDoc = await loanReference.add(request.toMap());
      await loanDoc.set(request.toMap());
      loanRequest(request);
      requestMessage = "Success";
    } catch (e) {
      return requestMessage;
    }
  }

  // function for members within the sacco to approve loan requested by a member

  memberLoanApproval(String memberId, LoanApprovalModel loan) async {
    var approvalReference = FirebaseFirestore.instance
        .collection('sacco')
        .doc()
        .collection('loan approvals');
    String? approvalStatus;
    List membersApproved = [];

    try {
      if (isApproved == true) {
        approvalStatus = "Approved";
        membersApproved.add(member!.id);
        approvalReference.add(loan.toMap());
      } else {
        if (isApproved == false) {
          approvalStatus = "Not Approved";
        }
      }
    } catch (e) {
      print(e);
    }
    return approvalStatus;
  }

  // get approval percentage

  getMemberApprovalPercentage(Sacco sacco, int count) {
    int? percent = 100;
    String? totalPercentage = '%';
    int? totalMembers = sacco.members.length;
  }

  //funds to be deposited after approval

  disburseLoanFundsToMember(String memberId, LoanRequest loan) async {
    List membersLoanedTo = [];
    var loanReference = FirebaseFirestore.instance
        .collection('sacco')
        .doc()
        .collection('loans');

    try {
      // requestLoan(memberId, loan.amount.toString());
      membersLoanedTo.add(memberId);
      DocumentReference fundsDisbursed = await loanReference.add(loan.toMap());
      await fundsDisbursed.set(
        loan.toMap(),
      );
    } catch (e) {
      print(e);
    }
    return membersLoanedTo;
  }

  // loan records within the sacco

  loanRecords(LoanRequest record) {
    var loanRecords = FirebaseFirestore.instance
        .collection('sacco')
        .doc()
        .collection('loans');
    try {
      record.dateOfRequest = Timestamp.now();
      loanRecords.add(record.toMap());
    } catch (e) {
      print(e);
    }
  }
}
