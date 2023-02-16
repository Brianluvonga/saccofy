import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saccofy/sacco/loan/models/loan_request_model.dart';
import 'package:saccofy/sacco/loan/notifier/loan_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/loan_request_notifier.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';

class LoanService {
  // FirebaseFirestore? _firestore;
  // Add a threshold for the number of member approvals required
  final double _approvalThreshold = 0.75;
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("saccos");

  CollectionReference usersRef = FirebaseFirestore.instance.collection("users");

  Future<void> submitLoanRequest(
      String userID, String saccoId, LoanRequest loanRequest) async {
    // Create a new loan request document
    DocumentReference loanRequestRef =
        firestore.doc(saccoId).collection('loanRequests').doc(userID);

    // Add the loan request ID to the loan request object
    loanRequest.id = userID;

    await loanRequestRef.set(
      loanRequest.toMap(),
    );

    // Create a reference to the new loan request in the user's collection
    usersRef.doc(userID).collection("loanRequests").doc(loanRequestRef.id);
  }

  // fetch loan requests from sacco
  fetchLoanRequests(UserModelNotifier user, LoanRequestNotifier loanNotifier,
      SaccoNotifier saccoNotifier) async {
    // Get all loan requests for a user in a sacco from Firestore
    QuerySnapshot snapshot = await firestore
        .doc(saccoNotifier.currentSacco.saccoId)
        .collection("loanRequests")
        .orderBy('dateOfRequest', descending: true)
        .get();
    // list to store the fetched loan details
    List<LoanRequest> loanList = [];

    // list to store the fetched loan details
    for (var document in snapshot.docs) {
      LoanRequest loanRequest =
          LoanRequest.fromMap(document.data() as Map<String, dynamic>);
      String? userId = loanRequest.id;
      DocumentSnapshot userSnapshot = await usersRef.doc(userId).get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      loanRequest.memberId = userData['firstname'];
      print(loanRequest.memberId = userData['firstname']);

      loanList.add(loanRequest);
    }

    loanNotifier.loanRequestlist = loanList;
  }

  Future<void> approveLoanRequest(
      String saccoId, String loanRequestId, String memberId) async {
    // Retrieve the loan request data
    DocumentSnapshot loanRequestSnapshot = await firestore
        .doc(saccoId)
        .collection('loanRequests')
        .doc(loanRequestId)
        .get();
    LoanRequest loanRequest =
        LoanRequest.fromMap(loanRequestSnapshot.data() as Map<String, dynamic>);

    // Get all member approvals for the loan request
    QuerySnapshot snapshot = await firestore
        .doc(saccoId)
        .collection("loanRequests")
        .doc(loanRequestId)
        .collection("approvals")
        .get();

    // get Approved members list
    List<dynamic> approvals =
        (loanRequestSnapshot.data()! as dynamic)['approvedMembers'];
    approvals.add(memberId);
    await firestore
        .doc(saccoId)
        .collection('loanRequests')
        .doc(loanRequestId)
        .update({'approvedMembers': approvals});

    // Calculate the percentage of member approvals
    double approvalPercentage = snapshot.size / loanRequest.members.length;

    // check to see if the approval percentage is greater than or equal to the member approval percentage
    if (approvalPercentage >= _approvalThreshold) {
      // Update the status of the loan request to "approved"
      await firestore
          .doc(saccoId)
          .collection('loanRequests')
          .doc(loanRequestId)
          .update({'status': 'approved'});

      // Retrieve the current deposit amount for the SACCO
      DocumentSnapshot saccoSnapshot =
          await firestore.doc(saccoId).collection('deposits').doc().get();
      double currentDepositAmount =
          (saccoSnapshot.data() as Map<String, dynamic>)['depositAmount'];
      // double newDepositAmount =
      //     currentDepositAmount - loanRequest.loanAmount!.toDouble();

      // // Update the loan amount for the SACCO
      // await firestore
      //     .doc(saccoId)
      //     .collection('loans')
      //     .doc()
      //     .update({'depositAmount': newDepositAmount});

      //create loan request history record
      DocumentReference docRef = await firestore
          .doc(loanRequest.saccoId)
          .collection('loanRequestHistory')
          .add(loanRequest.toMap());
      loanRequest.id = docRef.id;
      await docRef.set(loanRequest.toMap());
    }
  }

  // loan send to memebr who requested it
  disburseLoan() {}

  Future<void> rejectLoanRequest(
      String memberId, String saccoId, String loanRequestId) async {
    // Update the status of the loan request to "rejected"
    await firestore
        .doc(saccoId)
        .collection('loanRequest')
        .doc(loanRequestId)
        .update({'status': 'rejected'});
  }
}
