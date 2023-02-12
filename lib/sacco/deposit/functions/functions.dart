import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saccofy/sacco/deposit/model/member_contributions.dart';
import 'package:saccofy/sacco/deposit/notifier/deposit_notifier.dart';

class DepositService {
  // Firebase Instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to deposit to sacco
  Future<void> deposit(String saccoId, String userId, Deposit deposit) async {
    // Create a reference to the new deposit in the SACCO's collection
    DocumentReference depositRef = _firestore
        .collection("saccos")
        .doc(saccoId)
        .collection("deposits")
        .doc();

    // Convert the deposit object to a map
    Map<String, dynamic> depositMap = deposit.toMap();
    depositMap['depositID'] = depositRef.id;

    // Set the deposit data in the SACCO's collection
    await depositRef.set(depositMap);

    // Retrieve the current deposit amount for the SACCO
    DocumentSnapshot saccoSnapshot =
        await _firestore.collection("saccos").doc(saccoId).get();
    double currentDepositAmount =
        (saccoSnapshot.data() as Map<String, dynamic>)['depositAmount'];
    double newDepositAmount =
        currentDepositAmount + deposit.depositAmount!.toDouble();

    // Update the deposit amount for the SACCO
    await _firestore
        .collection("saccos")
        .doc(saccoId)
        .update({'depositAmount': newDepositAmount});

    //create deposit history record
    DocumentReference docRef = await _firestore
        .collection('saccos')
        .doc(saccoId)
        .collection('depositHistory')
        .add(deposit.toMap());
    deposit.depositID = docRef.id;
    await docRef.set(deposit.toMap());

    // Create a reference to the new deposit in the user's collection
    DocumentReference userDepositRef = _firestore
        .collection("users")
        .doc(userId)
        .collection("deposits")
        .doc(depositRef.id);
    // Set the deposit data in the user's collection
    await userDepositRef.set(depositMap);
  }

  //
  // Function to update the deposit amount for a user
  Future<void> updateUserDepositAmount(
      String userId, double depositAmount) async {
    DocumentReference userRef = _firestore.collection("users").doc(userId);

    // Retrieve the current deposit amount for the user
    DocumentSnapshot userSnapshot = await userRef.get();
    double currentDepositAmount =
        (userSnapshot.data() as Map<String, dynamic>)['depositAmount'];

    // Calculate the new deposit amount
    double newDepositAmount = currentDepositAmount + depositAmount;

    // Update the deposit amount for the user
    await userRef.update({'depositAmount': newDepositAmount});
  }

  // Function to retrieve deposit history for a SACCO
  Future<void> getSaccoDeposits(
      DepositNotifier depositNotifier, String saccoId) async {
    try {
      DocumentSnapshot querySnapshot = (await _firestore
          .collection('saccos')
          .doc(saccoId)
          .collection('deposits')
          .get()) as DocumentSnapshot<Object?>;

      List<Deposit> depositList = []; // initialize list of deposit

      if (querySnapshot.exists) {
        Deposit deposit =
            Deposit.fromMap(querySnapshot.data() as Map<String, dynamic>);
        depositList.add(deposit);
        depositNotifier.depositList = depositList;
      } else {
        throw Exception("No deposits found for Sacco with id: $saccoId");
      }
    } catch (e) {
      print("Error getting Sacco deposits: $e");
    }
  }

  // Function to retrieve deposit history for a user
  Future<List<Deposit>> getUserDepositHistory(String userId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('deposits')
        .get();
    return querySnapshot.docs
        .map(
          (doc) => Deposit.fromMap(doc.data as Map<String, dynamic>),
        )
        .toList();
  }
}

class NumbersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Function to retrieve total deposit amount for a SACCO
  Future<double> getSaccoTotalDeposit(String saccoId) async {
    double defaultValue = 0;
    try {
      DocumentSnapshot docSnapshot = (await _firestore
          .collection('saccos')
          .doc(saccoId)
          .collection('deposits')
          .get()) as DocumentSnapshot<Object?>;
      if (docSnapshot.exists) {
        return (docSnapshot.data() as Map<String, dynamic>)['depositAmount'] ??
            defaultValue;
      } else {
        return defaultValue;
      }
    } catch (e) {
      return defaultValue;
    }
  }

  // Function to retrieve total deposit amount for a user
  Future<double> getUserTotalDeposit(String userId) async {
    double defaultValue = 0;
    try {
      final QuerySnapshot docSnapshot = (await _firestore
          .collection('users')
          .doc(userId)
          .collection('deposits')
          .get());
      final DocumentSnapshot depositDoc = docSnapshot.docs.first;

      if (depositDoc.exists) {
        return (depositDoc.data()! as Map<String, dynamic>)['depositAmount'] ??
            defaultValue;
      } else {
        return defaultValue;
      }
    } catch (e) {
      print("An error occurred while retrieving user deposit: $e");
      return defaultValue;
    }
  }
}
