import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';

class Notifications {
  // fetch notification and notify other member of a new member
  fetchNewMemberNotification(String saccoId) async {
    final firestore = FirebaseFirestore.instance;

    // Get reference to the sacco's collection
    DocumentReference saccoRef = firestore.collection("saccos").doc(saccoId);

    // Query the notifications subcollection
    QuerySnapshot notificationsSnapshot =
        await saccoRef.collection("notifications").get();

    return notificationsSnapshot.docs;
  }
}
