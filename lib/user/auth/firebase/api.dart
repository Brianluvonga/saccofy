import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';
import 'package:uuid/uuid.dart';

CollectionReference userRef = FirebaseFirestore.instance.collection("users");

UserModel _currentUser = UserModel();

UserModel get currentUser => _currentUser;
//
//
//
Future<bool> signInUser(
  UserModel user,
  UserModelNotifier currentUser,
) async {
  UserNotifier? authNotifier;
  try {
    UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: user.email!.trim(), password: user.password!.trim());

    if (_currentUser != null) {
      currentUser.setCurrentUser(_currentUser);
    }

    User? firebaseUser = result.user;

    if (firebaseUser != null) {
      // authNotifier!.setUser(firebaseUser);
    }
  } catch (e) {
    print(e);
  }
  return false;
}

FirebaseAuth _user = FirebaseAuth.instance;
registerUser(UserModel user, bool isUpdating, File localFileImage,
    UserNotifier authNotifier) async {
  if (isUpdating) {
    user.updatedAt = Timestamp.now();
    await userRef.doc(_user.currentUser!.uid).update(user.toJson());
  }
  UserCredential registerResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email!.trim(), password: user.password!.trim())
      .catchError(
        // ignore: invalid_return_type_for_catch_error
        (error) => print(error.code),
      );
  user.id = registerResult.user!.uid;
  var imageUpload = path.extension(localFileImage.path);
  // Uuid uuid;
  Reference profilePic = FirebaseStorage.instance
      .ref()
      .child('profilePics/${registerResult.user!.uid}$imageUpload');
  await profilePic.putFile(localFileImage).catchError((onError) {
    return false;
  });
  String? imageUrl = await profilePic.getDownloadURL();
  user.profilePic = imageUrl;
  imageUrl = FirebaseAuth.instance.currentUser!.photoURL;

  // creating user collection
  userRef.doc(registerResult.user!.uid).set(user.toJson());
  // ignore: await_only_futures, avoid_single_cascade_in_expression_statements
  await FirebaseAuth.instance
    ..currentUser!.updateDisplayName("${user.firstname!} ${user.lastname}");
  // ignore: avoid_single_cascade_in_expression_statements
  FirebaseAuth.instance.currentUser!.updatePhotoURL("${user.profilePic}");
}

registerUserTwo(
  UserModel user,
  bool isUpdating,
  File localFileImage,
  BuildContext context,
  UserNotifier authNotifier,
) async {
  if (isUpdating) {
    // Check if a new image has been passed in
    // var imageUpload = path.extension(localFileImage.path);
    // Reference profilePic = FirebaseStorage.instance
    //     .ref(imageUpload)
    //     .child('profilePics/${_user.currentUser!.uid}');

    // Delete the old image from storage
    // Reference oldProfilePic = FirebaseStorage.instance
    //     .ref(imageUpload)
    //     .child('profilePics/${_user.currentUser!.uid}');
    // await oldProfilePic.delete();

    // // Upload the new image
    // await profilePic.putFile(localFileImage).catchError((onError) {
    //   return false;
    // });
    // String? imageUrl = await profilePic.getDownloadURL();
    // user.profilePic = imageUrl;
    user.updatedAt = Timestamp.now();
    // ignore: avoid_single_cascade_in_expression_statements
    FirebaseAuth.instance
      ..currentUser!.updateDisplayName("${user.firstname!} ${user.lastname}");
    await userRef.doc(_user.currentUser!.uid).update(user.toJson());
    // ignore: avoid_single_cascade_in_expression_statements

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  } else {
    UserCredential registerResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email!.trim(), password: user.password!.trim())
        .catchError(
          // ignore: invalid_return_type_for_catch_error
          (error) => print(error.code),
        );
    user.id = registerResult.user!.uid;

    Reference profilePic = FirebaseStorage.instance
        .ref()
        .child('profilePics/${registerResult.user!.uid}');
    await profilePic.putFile(localFileImage).catchError(
      (onError) {
        return false;
      },
    );
    String? imageUrl = await profilePic.getDownloadURL();
    user.profilePic = imageUrl;
    imageUrl = FirebaseAuth.instance.currentUser!.photoURL;
    // creating user collection
    userRef.doc(registerResult.user!.uid).set(user.toJson());
    // ignore: await_only_futures, avoid_single_cascade_in_expression_statements
    await FirebaseAuth.instance
      ..currentUser!.updateDisplayName("${user.firstname!} ${user.lastname}");
    // ignore: avoid_single_cascade_in_expression_statements
    FirebaseAuth.instance.currentUser!.updatePhotoURL("${user.profilePic}");
  }
}

deleteUser(UserModel user, AuthNotifier authNotifier) async {}

//=========================== INITIALIZE CURRENT USER ==========================

initializeCurrentUser(AuthNotifier authNotifier) async {
  var appUser = FirebaseAuth.instance.currentUser;
  authNotifier.setUser(appUser);
}

CollectionReference usersRef = FirebaseFirestore.instance.collection("users");

//
//
//fetch details of logged in user
Future<UserModel> getLoggedInUser(String? uid) async {
  //initiate user
  UserModel user = UserModel();

  //
  //

  try {
    DocumentSnapshot snapshot = await usersRef.doc(uid).get();
    user.firstname = snapshot.get('firstname');
    user.lastname = snapshot.get('lastname');
    user.email = snapshot.get('email');
    user.gender = snapshot.get('gender');
    user.phonenumber = snapshot.get('phonenumber');
    user.yob = snapshot.get('yob');
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }

  return user;
}

FirebaseFirestore sRef = FirebaseFirestore.instance;

fetchUser(UserModelNotifier userNotifier, String uid) async {
  var snap = (await sRef.collection('users').doc(uid).get());
  List<UserModel> memberList = [];

  // for (var doc in snap.docs) {
  UserModel member = UserModel.fromJson(snap.data() as Map<String, dynamic>);

  memberList.add(member);
  // }
  userNotifier.userList = memberList;
}

//
//============================ RESET USER PASSWORD =============================

resetUserPassword(String emailAddress) async {
  List<String> signInMethods =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

  if (signInMethods.isEmpty) {
    return "This email address is not registered";
  }
  try {
    return await _user.sendPasswordResetEmail(
      email: emailAddress.toString(),
    );
  } catch (e) {
    return e;
  }
}

//======================= LOG USER OUT =========================================
//

signOutUser(AuthNotifier authNotifier, context, uid) async {
  await FirebaseAuth.instance.signOut().catchError(
        (error) => print(error),
      );

  authNotifier.setUser(null);
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => const LoginUserForm(),
    ),
  );
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<int> getUserNumberOfSaccos(String userId) async {
  // Retrieve the user data from Firestore
  DocumentSnapshot userSnapshot =
      await _firestore.collection("users").doc(userId).get();

  // Split the user ID by the SACCO ID separator
  List<dynamic> saccos =
      (userSnapshot.data()! as Map<String, dynamic>)["saccoId"];
  // Count the number of SACCO IDs
  int numSaccos = saccos.length;
  return numSaccos;
}

Future<double> checkPersonalSavings(String userId) async {
  double totalSavings = 0;
  try {
    // Get the user document from the "users" collection
    DocumentSnapshot userDoc = await sRef.collection("users").doc(userId).get();

    // Get the "personal savings" sub-collection from the user document
    CollectionReference personalSavingsRef =
        userDoc.reference.collection("personal savings");

    // Query the personal savings
    QuerySnapshot personalSavingsSnapshot = await personalSavingsRef.get();

    //iterate over the documents in the subcollection
    for (DocumentSnapshot ds in personalSavingsSnapshot.docs) {
      // access the value of the "amount" field in the personal savings document
      totalSavings += (ds.data()! as Map<String, dynamic>)["amount"];
    }
  } catch (e) {
    print("Error while fetching savings data $e");
  }
  return totalSavings;
}
