import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saccofy/sacco/loan/models/loan_request_model.dart';

class LoanService {
  final FirebaseFirestore _firestore;
  // Add a threshold for the number of member approvals required
  final double _approvalThreshold = 0.75;

  LoanService(this._firestore);

  Future<void> submitLoanRequest(
      String saccoId, LoanRequest loanRequest) async {
    // Create a new loan request document
    CollectionReference loanRequestRef =
        _firestore.collection("saccos").doc(saccoId).collection('loanRequests');

    // Add the loan request ID to the loan request object
    loanRequest.id = loanRequestRef.id;

    // Convert the loan request object to a map
    Map<String, dynamic> loanRequestMap = loanRequest.toMap();

    // Add the loan request map to the new loan request document
    await loanRequestRef.add(loanRequestMap);

    // Create a reference to the new loan request in the user's collection
    DocumentReference userLoanRequestRef = _firestore
        .collection("users")
        .doc(loanRequest.memberId)
        .collection("loanRequests")
        .doc(loanRequestRef.id);

    // Add the loan request map to the user's loan request collection
    await userLoanRequestRef.set(loanRequestMap);
  }

  // fetch loan requests from sacco
  Future<List<LoanRequest>> fetchLoanRequests(String saccoId) async {
    // Get all loan requests for a user in a sacco from Firestore
    QuerySnapshot snapshot = await _firestore
        .collection("saccos")
        .doc(saccoId)
        .collection("loanRequests")
        .get();

    // Convert the snapshot data to a list of loan request objects
    return snapshot.docs
        .map((doc) => LoanRequest.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    // will store in a model
  }

  Future<void> approveLoanRequest(
      String saccoId, String loanRequestId, String memberId) async {
    // Retrieve the loan request data
    DocumentSnapshot loanRequestSnapshot = await _firestore
        .collection("saccos")
        .doc(saccoId)
        .collection('loanRequests')
        .doc(loanRequestId)
        .get();
    LoanRequest loanRequest =
        LoanRequest.fromMap(loanRequestSnapshot.data() as Map<String, dynamic>);

    // Get all member approvals for the loan request
    QuerySnapshot snapshot = await _firestore
        .collection("saccos")
        .doc(saccoId)
        .collection("loanRequests")
        .doc(loanRequestId)
        .collection("approvals")
        .get();

    // get Approved members list
    List<dynamic> approvals =
        (loanRequestSnapshot.data()! as dynamic)['approvedMembers'];
    approvals.add(memberId);
    await _firestore
        .collection("saccos")
        .doc(saccoId)
        .collection('loanRequests')
        .doc(loanRequestId)
        .update({'approvedMembers': approvals});

    // Calculate the percentage of member approvals
    double approvalPercentage = snapshot.size / loanRequest.members.length;

    // check to see if the approval percentage is greater than or equal to the member approval percentage
    if (approvalPercentage >= _approvalThreshold) {
      // Update the status of the loan request to "approved"
      await _firestore
          .collection("saccos")
          .doc(saccoId)
          .collection('loanRequests')
          .doc(loanRequestId)
          .update({'status': 'approved'});

      // Retrieve the current deposit amount for the SACCO
      DocumentSnapshot saccoSnapshot = await _firestore
          .collection("saccos")
          .doc(saccoId)
          .collection('deposits')
          .doc()
          .get();
      double currentDepositAmount =
          (saccoSnapshot.data() as Map<String, dynamic>)['depositAmount'];
      double newDepositAmount =
          currentDepositAmount - loanRequest.loanAmount!.toDouble();

      // Update the loan amount for the SACCO
      await _firestore
          .collection("saccos")
          .doc(saccoId)
          .collection('loans')
          .doc()
          .update({'depositAmount': newDepositAmount});

      //create loan request history record
      DocumentReference docRef = await _firestore
          .collection('saccos')
          .doc(loanRequest.saccoId)
          .collection('loanRequestHistory')
          .add(loanRequest.toMap());
      loanRequest.id = docRef.id;
      await docRef.set(loanRequest.toMap());
    }
  }

  Future<void> rejectLoanRequest(
      String memberId, String saccoId, String loanRequestId) async {
    // Update the status of the loan request to "rejected"
    await _firestore
        .collection("saccos")
        .doc(saccoId)
        .collection('loanRequest')
        .doc(loanRequestId)
        .update({'status': 'rejected'});
  }
}
