import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

CollectionReference userRef = FirebaseFirestore.instance.collection("users");

//
//
//
signInUser(UserModel user, AuthNotifier authNotifier) async {
  UserCredential result = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
          email: user.email!.trim(), password: user.password!.trim())
      .catchError(
        (error) => print(error.code),
      );

  User? firebaseUser = result.user;

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

FirebaseAuth _user = FirebaseAuth.instance;
registerUser(UserModel user, AuthNotifier authNotifier) async {
  UserCredential registerResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email!.trim(), password: user.password!.trim())
      .catchError(
        (error) => print(error.code),
      );
  userRef.doc(registerResult.user!.uid).set(user.toJson());
  // ignore: await_only_futures, avoid_single_cascade_in_expression_statements
  await FirebaseAuth.instance
    ..currentUser!.updateDisplayName("${user.firstname!} ${user.lastname}");

  User? firebaseUser = registerResult.user;

  if (firebaseUser != null) {
    await firebaseUser.reload();
    User currentUser = FirebaseAuth.instance.currentUser!;
    authNotifier.setUser(currentUser);
  }
}

//=========================== INITIALIZE CURRENT USER ==========================

initializeCurrentUser(AuthNotifier authNotifier) async {
  var appUser = FirebaseAuth.instance.currentUser;
  authNotifier.setUser(appUser!);
}

CollectionReference usersRef = FirebaseFirestore.instance.collection("users");

Future<UserModel> getLoggedInUser(String uid) async {
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
    print(e);
  }

  return user;
}

//=================== END User =================================================

//
//============================ RESET USER PASSWORD =============================

resetUserPassword(AuthNotifier? authNotifier) async {
  try {
    if (authNotifier!.user!.email != null) {
      return await _user.sendPasswordResetEmail(
        email: authNotifier.user!.email.toString(),
      );
    }
  } catch (e) {
    return e;
  }
}

//======================= LOG USER OUT =========================================
//

signOutUser(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError(
        (error) => print(error.code),
      );

  authNotifier.setUser;
  const LoginUserForm();
}
