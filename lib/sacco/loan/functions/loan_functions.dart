import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';
import 'package:saccofy/sacco/loan/models/approve_loan.dart';
import 'package:saccofy/sacco/loan/models/loan_request_model.dart';
import 'package:saccofy/sacco/loan/notifier/loan_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/loan_request_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/member_approval_notifier.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

class LoanService {
  // FirebaseFirestore? _firestore;
  // Add a threshold for the number of member approvals required
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
    DocumentReference userSref =
        usersRef.doc(userID).collection("loanRequests").doc(loanRequestRef.id);
    await userSref.set(loanRequest.toMap());
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

  approveLoanRequest(LoanRequestNotifier loanNotifier, String saccoId,
      String currentMemberID) async {
    ApproveLoan approve = ApproveLoan();
    // Retrieve the loan request data
    DocumentSnapshot loanRequestSnapshot = await firestore
        .doc(saccoId)
        .collection('loanRequests')
        .doc(loanNotifier.currentLoan.id)
        .get();

    print(loanRequestSnapshot.data());

    // Check if the loan request exists
    if (loanRequestSnapshot.exists) {
      // Check if the loan is not already approved
      if (!approve.isApproved) {
        approve.isApproved = true;

        // Mark the current member's approval as true
        approve.memberApprovals[currentMemberID] = true;

        // Update the approval status of the specific member who approved the loan

        DocumentReference loanDocRef = firestore
            .doc(saccoId)
            .collection('approvedLoans')
            .doc(loanNotifier.currentLoan.id);

// Get the existing document to check if the memberApprovals field exists
        DocumentSnapshot loanDocSnapshot = await loanDocRef.get();

        if (loanDocSnapshot.exists) {
          // If the memberApprovals field exists, append the new member ID to the array
          await loanDocRef.update({
            // 'approved': true,
            'memberApprovals': FieldValue.arrayUnion([
              currentMemberID,
            ]),
          });
        } else {
          // If the memberApprovals field doesn't exist, create it with the new member ID
          await loanDocRef.set({
            'approved': true,
            'memberApprovals': [currentMemberID],
          });
        }

        // Get the total number of members in the sacco
        DocumentSnapshot saccoSnapshot = await firestore.doc(saccoId).get();
        List members =
            (saccoSnapshot.data() as Map<String, dynamic>)['members'];
        int totalMemberCount = members.length;

        // Check if enough members have approved the loan
        int approvedMemberCount = approve.memberApprovals.values
            .where((approval) => approval == true)
            .length;
        double approvalPercentage = approvedMemberCount / totalMemberCount;
        if (approvalPercentage >= 0.75) {
          // Mark the loan as approved
          approve.isApproved = true;
          await loanRequestSnapshot.reference.update({'status': 'approved'});

          // Disburse the loan funds to the borrower's account
          // await disburseLoanFunds(
          //     loanRequestSnapshot, loanNotifier.currentLoan.saccoId.toString());
        }
      } else {
        // The loan is already approved, so do nothing
      }
    } else {
      // The loan request does not exist, so throw an error
      throw 'Loan request not found';
    }
  }

  Future<List<UserModel>> getMembersWhoApprovedLoan(
      MemberApprovalNotifier approvedMember,
      String loanId,
      String saccoId) async {
    // Get the approved loan document for the specified loan ID
    DocumentSnapshot approvedLoanSnapshot = await FirebaseFirestore.instance
        .collection('saccos')
        .doc(saccoId)
        .collection('approvedLoans')
        .doc(loanId)
        .get();

    // Check if the loan was found
    if (approvedLoanSnapshot.exists) {
      // Get the member approvals array
      List<String> memberApprovalIDs = List<String>.from((approvedLoanSnapshot
          .data() as Map<String, dynamic>)['memberApprovals']);
      print(memberApprovalIDs);
      List<UserModel> approvedMembers = [];

      for (String memberApprovalID in memberApprovalIDs) {
        DocumentSnapshot memberSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(memberApprovalID)
            .get();

        UserModel member =
            UserModel.fromJson(memberSnapshot.data() as Map<String, dynamic>);
        approvedMembers.add(member);
      }

      approvedMember.memberLoanApprovalList = approvedMembers;

      return approvedMembers;
    } else {
      return [];
    }
  }

  // fetch number of members of who have approved a given loan
  Future<int> numberOfApprovals(String saccoId, String loanId) async {
    int approvedCount = 0;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('saccos')
        .doc(saccoId)
        .collection('approvedLoans')
        .doc(loanId)
        .get();

    if (snapshot.exists) {
      // Get the total number of members who have approved the loan
      List<dynamic> memberApprovals = snapshot.get('memberApprovals');
      approvedCount = memberApprovals.length;
    }

    return approvedCount;
  }

  // loan send to memebr who requested it
  disburseLoanFunds(
      DocumentSnapshot loanRequestSnapshot, String saccoId) async {
    // Retrieve the loan request data
    Map<String, dynamic> loanRequestData =
        loanRequestSnapshot.data()! as Map<String, dynamic>;
    String borrowerID = loanRequestData['loanID'];
    double loanAmount = loanRequestData['amount'];

    // Retrieve the SACCO account data
    DocumentSnapshot saccoAccountSnapshot = (await firestore
        .doc(saccoId)
        .collection('deposits')
        .get()) as DocumentSnapshot<Object?>;
    double saccoAccountBalance =
        (saccoAccountSnapshot.data() as Map<String, dynamic>)['depositAmount'];

    // Check if the SACCO has sufficient funds to disburse the loan
    if (loanAmount <= saccoAccountBalance) {
      // Subtract the loan amount from the SACCO account balance
      await saccoAccountSnapshot.reference
          .update({'depositAmount': saccoAccountBalance - loanAmount});

      // Add the loan amount to the borrower's account balance
      await usersRef
          .doc(borrowerID)
          .update({'accountBalance': FieldValue.increment(loanAmount)});

      // Create a transaction record in the database
      await firestore.doc(saccoId).collection('disbursements').add({
        'type': 'loan',
        'amount': loanAmount,
        'from': 'sacco',
        'to': borrowerID,
        'timestamp': FieldValue.serverTimestamp()
      });

      // Mark the loan request as approved in the database
      await loanRequestSnapshot.reference.update({'isApproved': true});
    } else {
      // Mark the loan request as partially approved in the database
      await loanRequestSnapshot.reference.update({'isApproved': false});
    }
  }

  Future<void> rejectLoanRequest(
      String memberId, String saccoId, String loanRequestId) async {
    // Update the status of the loan request to "rejected"
    await firestore
        .doc(saccoId)
        .collection('loanRequest')
        .doc(loanRequestId)
        .update({'status': 'rejected'});
  }

  // INDIVIDUAL SECTION TO QUERY COLLECTION FOR ANY LOAN ACTIVITIES
  // fetch loan requests from sacco
  fetchIndividualLoanRequests(String userID, LoanRequestNotifier loan) async {
    // Get all loan requests for a user in a sacco from Firestore
    QuerySnapshot snapshot = await usersRef
        .doc(userID)
        .collection("loanRequests")
        .orderBy('dateOfRequest', descending: true)
        .get();
    // list to store the fetched loan details
    List<LoanRequest> loanList = [];

    // list to store the fetched loan details
    for (var document in snapshot.docs) {
      LoanRequest loanRequest =
          LoanRequest.fromMap(document.data() as Map<String, dynamic>);

      loanList.add(loanRequest);
    }

    loan.loanRequestlist = loanList;
  }

  fetchMemberLoanRequests(
      MemberNotifier memberID, LoanRequestNotifier loanRequest) async {
    // Get all loan requests for a user in a sacco from Firestore
    QuerySnapshot snapshot = await usersRef
        .doc(memberID.currentMember.id)
        .collection("loanRequests")
        .orderBy('dateOfRequest', descending: true)
        .get();
    // list to store the fetched loan details
    List<LoanRequest> loanList = [];
    // list to store the fetched loan details
    for (var document in snapshot.docs) {
      LoanRequest loanRequest =
          LoanRequest.fromMap(document.data() as Map<String, dynamic>);

      loanList.add(loanRequest);
    }
    print(loanList.length);

    loanRequest.loanRequestlist = loanList;
  }
}
