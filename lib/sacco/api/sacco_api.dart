import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

CollectionReference saccoRef = FirebaseFirestore.instance.collection("saccos");
CollectionReference usersRef = FirebaseFirestore.instance.collection("users");

UserModel userModel = UserModel();

createSacco(Sacco sacco, bool isUpdating, String userUID) async {
  sacco.createdDate = Timestamp.now();

  if (isUpdating) {
    sacco.updatedDate = Timestamp.now();
    await saccoRef.doc(sacco.saccoName).update(sacco.toMap());
  } else {
    List members = [];
    members.add(userUID);

    await saccoRef.doc(userUID).set({
      'saccoId': userUID,
      'saccoName': sacco.saccoName,
      'admin': userUID,
      'type': sacco.type,
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
  String? joinError = "Unable To Join Sacco, Please Try Again";
  List members = [];
  try {
    members.add(userId);
    await saccoRef.doc(saccoId).update(
      {'members': FieldValue.arrayUnion(members)},
    );

    await usersRef.doc(userId).update({'saccoId': saccoRef.id});
    joinError = "Successfully joined the Sacco";
  } catch (e) {
    return e;
  }
  return joinError;
}

//
//
//

//join link to sacco created
saccoInvitationLink(String? saccoName, String saccoId) {
  FirebaseDynamicLinks joinLink = FirebaseDynamicLinks.instance;
}

User? user = FirebaseAuth
    .instance.currentUser; //fetch details of current user thats current
FirebaseFirestore sRef = FirebaseFirestore.instance;

fetchSacco(SaccoNotifier saccoNotifier, String uid) async {
  QuerySnapshot<Map<String, dynamic>> snap = await sRef
      .collection('saccos')
      .where('saccoId', isEqualTo: uid)
      // .orderBy("createdAt", descending: true)
      .get();

  List<Sacco> saccoList = [];
  List<UserModel> memberList = [];

  for (var doc in snap.docs) {
    Sacco sacco = Sacco.fromMap(doc.data());
    UserModel member = UserModel.fromJson(doc.data());

    saccoList.add(sacco);
    memberList.add(member);
  }
  saccoNotifier.saccoList = saccoList;
}

getSaccoMember(SaccoNotifier saccoNotifier, String memberId) async {
  var saccoCollection = await FirebaseFirestore.instance
      .collection('sacco')
      .where('members', isEqualTo: memberId)
      .get();

  // var userCollection = await FirebaseFirestore.instance.collection('users').get();

  List<UserModel> saccoMembers = [];
  for (var doc in saccoCollection.docs) {
    UserModel members = UserModel.fromJson(doc.data());
    saccoMembers.add(members);
  }
  print(saccoMembers);
  saccoNotifier.memberList = saccoMembers;
}

getDetailsOfLoggedInUser(AuthNotifier activeUser) async {
  UserModel? user;
  var sol = await usersRef.doc(activeUser.user!.uid).get();
  user!.firstname = sol.get('firstname');
  user.lastname = sol.get('lastname');
  user.email = sol.get('email');
  user.gender = sol.get('gender');
  user.phonenumber = sol.get('phonenumber');
  user.yob = sol.get('yob');
}

FirebaseAuth auth = FirebaseAuth.instance;

Future<List<String>> getSaccoMembers(MemberNotifier member) async {
  String uid = auth.currentUser!.uid;
  List currentMember = [];
  List saccoGroup = [];

  //fetch user from document
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get()
      .then((DocumentSnapshot snapshot) {
    currentMember.add(snapshot.data);
  });

  //get saccoId from current member

  var saccoId = currentMember[0]['saccoId'];

  //fetch sacco document
  await FirebaseFirestore.instance
      .collection('saccos')
      .doc(saccoId)
      .get()
      .then((value) => saccoGroup.add(value.data));

  member.memberList = saccoGroup[0]['members'];

  return saccoGroup[0]['members'];
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
