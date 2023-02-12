import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';

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
  BuildContext context,
) async {
  //
  if (!isUpdating) {
    bool hasSacco = false;
    await saccoRef.where('saccoId', isEqualTo: userUID).get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        hasSacco = true;
      }
    });

    if (hasSacco) {
      // show message to user
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 4),
          content: Text(
              'You already have an existing Sacco!, You Cannot Create More Than Two Saccos'),
        ),
      );
      // prevent user from creating a new Sacco
      return;
    }
  }

  if (isUpdating) {
    sacco.updatedDate = Timestamp.now();
    await saccoRef.doc(userUID).update(sacco.toMap());
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        padding: EdgeInsets.only(left: 130, bottom: 50),
        backgroundColor: Color(0xff1c3751),
        duration: Duration(seconds: 4),
        content: Text('Sacco Updated Successfully!'),
      ),
    );
  } else {
    sacco.createdDate = Timestamp.now();

    List members = [];
    members.add(userUID);

    // generate link to the sacco
    // var inivitationLink = await saccoInviteLink(userUID);

    await saccoRef.doc(userUID).set({
      'saccoId': userUID,
      'saccoName': sacco.saccoName,
      'admin': userUID,
      'type': sacco.type,
      // 'saccoLink': inivitationLink,
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
        'saccoId': FieldValue.arrayUnion([userUID]),
      },
    );
  }
}

Future<String> joinSacco(String userId, String saccoId) async {
  String? joinMsg = "Unable To Join Sacco, Please Try Again";
  List members = [];
  try {
    // check if user registered on the app
    DocumentSnapshot checkUserRegisteredSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (checkUserRegisteredSnapshot.exists) {
      print('Already Registered');
      members.add(userId);

      // query sacco collection for the document with saccoId
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('saccos')
          .doc(saccoId)
          .get();
      print(snap);

      if (snap.exists) {
        // fetch the sacco doc and update the members field

        // print(saccoDoc);
        await snap.reference
            .update({'members': FieldValue.arrayUnion(members)});

        // update the user document with the saccoId

        await FirebaseFirestore.instance.collection('users').doc(userId).update(
          {
            'saccoId': FieldValue.arrayUnion(
              [snap.reference.id],
            ),
          },
        );

        joinMsg = "Successfully joined the Sacco";
      }
    } else {
      // redirect to registration page

      joinMsg = "Please register to join the Sacco";
    }
  } catch (e) {
    return e.toString();
  }
  return joinMsg;
}

// add user to sacco
Future<String> addUserToSacco(String email, String saccoId) async {
  String? addUserMessage = "Unable To Add User To Sacco, Please Try Again";
  List members = [];
  try {
    // check if user is registered on the app
    QuerySnapshot checkUserRegisteredSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (checkUserRegisteredSnapshot.docs.isNotEmpty) {
      print('User Already Registered');
      DocumentSnapshot userDoc = checkUserRegisteredSnapshot.docs.first;
      if ((userDoc.data() as Map<String, dynamic>)['saccoId']
              ?.contains(saccoId) ==
          true) {
        return "User Is Already a Member Of The Sacco";
      }
      members.add(checkUserRegisteredSnapshot.docs.first.id);

      // query sacco collection for the document with saccoId
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('saccos')
          .doc(saccoId)
          .get();
      print(snap);

      if (snap.exists) {
        // fetch the sacco doc and update the members field

        // print(saccoDoc);
        await snap.reference
            .update({'members': FieldValue.arrayUnion(members)});

        // update the user document with the saccoId

        await FirebaseFirestore.instance
            .collection('users')
            .doc(checkUserRegisteredSnapshot.docs.first.id)
            .update({
          'saccoId': FieldValue.arrayUnion(
            [snap.reference.id],
          ),
        });

        addUserMessage = "Successfully added user to the Sacco";
      }
    } else {
      // show error message to indicate user is not registered on the app

      addUserMessage = "User is not registered on the app";
    }
  } catch (e) {
    return e.toString();
  }
  return addUserMessage;
}

Future<Uri> saccoInviteLink(String saccoId) async {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: "https://joinsaccofy.lupintech.co.ke",
    link: Uri.parse("https://joinsaccofy.lupintech.co.ke/join/id=$saccoId"),
    androidParameters: const AndroidParameters(
      packageName: 'com.example.saccofy',
      minimumVersion: 1,
    ),
    iosParameters: const IOSParameters(
      bundleId: 'com.example.saccofy',
      minimumVersion: '1.0.1',
    ),
    socialMetaTagParameters: const SocialMetaTagParameters(
      title: 'Join My Sacco',
      description: 'Click this link to join my sacco on the Example app',
    ),
  );

  // Uri url;
  final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters);

  final Uri shortUri = shortLink.shortUrl;
  return shortUri;
}

// remove a member from sacco
removeMemberFromSacco(
    String memberId, String saccoId, BuildContext context) async {
  await saccoRef.doc(saccoId).update({
    'members': FieldValue.arrayRemove([memberId]),
  });
  await FirebaseFirestore.instance.collection('users').doc(memberId).update(
    {
      'saccoId': FieldValue.arrayRemove([saccoId]),
    },
  );
  // show message to user
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      duration: Duration(seconds: 2),
      content: Text('Member removed from Sacco successfully!'),
    ),
  );
}

User? user = FirebaseAuth
    .instance.currentUser; //fetch details of current user thats current
FirebaseFirestore sRef = FirebaseFirestore.instance;

fetchSacco(SaccoNotifier saccoNotifier, String uid) async {
  try {
    DocumentSnapshot userSnap = await sRef.collection('users').doc(uid).get();

    if (userSnap.exists) {
      var saccoIds = (userSnap.get('saccoId'));
      print(saccoIds);
      if (saccoIds == null) {
        saccoNotifier.saccoList = [];
        return false;
      }

      List<Sacco> saccoList = [];
      for (var id in saccoIds) {
        DocumentSnapshot saccoSnap =
            await sRef.collection('saccos').doc(id).get();

        print(saccoSnap.exists);
        if (saccoSnap.exists) {
          Sacco sacco = Sacco.fromMap(saccoSnap.data() as Map<String, dynamic>);
          saccoList.add(sacco);
        }
      }

      saccoNotifier.saccoList = saccoList;
      return true;
    } else {
      throw Exception("User Document not found");
    }
  } catch (e) {
    print(e);
  }
}

// fetchSacco(SaccoNotifier saccoNotifier, String uid) async {
//   try {
//     DocumentSnapshot userSnap = await sRef.collection('users').doc(uid).get();

//     if (userSnap.exists) {
//       var saccoId = (userSnap.get('saccoId'));
//       print(saccoId);
//       if (saccoId == null) {
//         saccoNotifier.saccoList = [];
//         return false;
//       }
//       List<Sacco> saccosList = [];
//       DocumentSnapshot saccoSnap =
//           await sRef.collection('saccos').doc(saccoId.first).get();

//       print(saccoSnap.exists);
//       if (saccoSnap.exists) {
//         Sacco sacco = Sacco.fromMap(saccoSnap.data() as Map<String, dynamic>);
//         saccoNotifier.saccoList = [sacco];
//         return true;
//       } else {
//         saccoNotifier.saccoList = [];
//         return false;
//       }
//     } else {
//       throw Exception("User Document not found");
//     }
//   } catch (e) {
//     print(e);
//   }
// }

FirebaseAuth auth = FirebaseAuth.instance;

Future<List<UserModel>> getSaccoMembers(
    MemberNotifier memberNotifier, String saccoID) async {
  // query saccos collection for the sacco document

  DocumentSnapshot saccoSnapshot =
      await FirebaseFirestore.instance.collection('saccos').doc(saccoID).get();

  // get the list of member IDs for the sacco document
  List<dynamic> memberIDs = saccoSnapshot['members'];

  // fetch the details of each member from user collection
  List<UserModel> members = [];

  for (String memberID in memberIDs) {
    DocumentSnapshot memberSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(memberID)
        .get();

    UserModel member =
        UserModel.fromJson(memberSnapshot.data() as Map<String, dynamic>);
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
