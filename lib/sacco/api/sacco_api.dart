import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';
import 'package:uuid/uuid.dart';

CollectionReference saccoRef = FirebaseFirestore.instance.collection("saccos");
CollectionReference usersRef = FirebaseFirestore.instance.collection("users");

UserModel userModel = UserModel();

// create sacco and store details to sacco collection
createSacco(
  Sacco sacco,
  bool isUpdating,
  String userUID,
) async {
  if (isUpdating) {
    sacco.updatedDate = Timestamp.now();
    await saccoRef.doc(userUID).update(sacco.toMap());
  } else {
    sacco.createdDate = Timestamp.now();

    List members = [];
    members.add(userUID);

    // generate link to the sacco

    var inivitationLink = await saccoInviteLink(sacco.saccoId.toString());

    await saccoRef.doc(userUID).set({
      'saccoId': userUID,
      'saccoName': sacco.saccoName,
      'admin': userUID,
      'type': sacco.type,
      'saccoLink': inivitationLink,
      'termconditions': sacco.termconditions,
      'period': sacco.period,
      'members': members,
      'purpose': sacco.purpose,
      'aboutSacco': sacco.aboutSacco,
      'createdDate': sacco.createdDate,
      'updatedDate': sacco.updatedDate,
    });
    await FirebaseFirestore.instance.collection('users').doc(userUID).update(
      {
        'saccoId': userUID,
      },
    );
  }
}

joinSacco(String userId, String saccoId) async {
  String? joinMsg = "Unable To Join Sacco, Please Try Again";
  List members = [];
  try {
    // check if user registered on the app
    DocumentSnapshot checkUserRegisteredSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (checkUserRegisteredSnapshot.exists) {
      members.add(userId);

      // query sacco collection for the document with saccoId
      QuerySnapshot snap = FirebaseFirestore.instance
          .collection('saccos')
          .where('saccoId', isEqualTo: saccoId)
          .get() as QuerySnapshot<Object?>;

      if (snap.docs.isNotEmpty) {
        // fetch the sacco doc and update the members field
        DocumentSnapshot saccoDoc = snap.docs.first;
        await saccoDoc.reference
            .update({'members': FieldValue.arrayUnion(members)});

        // update the user document with the saccoId

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'saccoId': saccoDoc.reference.id});

        joinMsg = "Successfully joined the Sacco";
      }
    } else {
      // redirect to registration page

      joinMsg = "Please register to join the Sacco";
    }
  } catch (e) {
    return e;
  }
  return joinMsg;
}

saccoInviteLink(String saccoId) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://saccofy.formility.co.ke',
    link: Uri.parse('https://saccofy.formility.co.ke$saccoId'),
    androidParameters: const AndroidParameters(
      packageName: 'com.example.saccofy',
    ),
    iosParameters: const IOSParameters(
      bundleId: 'com.example.saccofy',
    ),
  );

  final Uri? inviteUrl = parameters.longDynamicLink;
  return inviteUrl;
}

User? user = FirebaseAuth
    .instance.currentUser; //fetch details of current user thats current
FirebaseFirestore sRef = FirebaseFirestore.instance;

fetchSacco(SaccoNotifier saccoNotifier, String uid) async {
  QuerySnapshot<Map<String, dynamic>> snap =
      await sRef.collection('saccos').where('saccoId', isEqualTo: uid).get();

  List<Sacco> saccoList = [];

  for (var doc in snap.docs) {
    Sacco sacco = Sacco.fromMap(doc.data());

    saccoList.add(sacco);
  }
  saccoNotifier.saccoList = saccoList;
}

FirebaseAuth auth = FirebaseAuth.instance;

Future<List<UserModel>> getSaccoMembers(
    MemberNotifier memberNotifier, String saccoID) async {
  // query saccos collection for the sacco document

  DocumentSnapshot saccoSnapshot =
      await FirebaseFirestore.instance.collection('saccos').doc(saccoID).get();

  // get the list of member IDs for the sacco document
  List<String> memberIDs = saccoSnapshot['members'];

  // fetch the details of each member from user collection
  List<UserModel> members = [];

  for (String memberID in memberIDs) {
    DocumentSnapshot memberSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(memberID)
        .get();

    UserModel member =
        UserModel.fromJson(memberSnapshot as Map<String, dynamic>);
    members.add(member);
  }
  memberNotifier.memberList = members;

  return members;
}

//function to delete sacco by admin
deleteSacco(Sacco sacco, String userId) async {
  await FirebaseFirestore.instance.collection('assets').doc(userId).delete();
}

updateSacco(Sacco sacco, String saccoId) async {
  await FirebaseFirestore.instance.collection('assets').doc(saccoId).update({});
}

removeSaccoMember(Sacco sacco, String member) async {
  var ref = await saccoRef.doc(member).delete();
  return ref;
}
