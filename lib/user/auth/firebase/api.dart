import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

CollectionReference userRef = FirebaseFirestore.instance.collection("users");

UserModel _currentUser = UserModel();

UserModel get currentUser => _currentUser;
//
//
//
signInUser(UserModel user, UserModelNotifier currentUser) async {
  AuthNotifier? authNotifier;
  UserCredential result = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
          email: user.email!.trim(), password: user.password!.trim())
      .catchError(
        (error) => print(error.code),
      );

  _currentUser = await getLoggedInUser(result.user!.uid);
  print(_currentUser);

  if (_currentUser != null) {
    print(_currentUser);
    currentUser.setCurrentUser(_currentUser);
  }

  User? firebaseUser = result.user;

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier?.setUser(firebaseUser);
  }
}

FirebaseAuth _user = FirebaseAuth.instance;
registerUser(UserModel user, bool isUpdating, AuthNotifier authNotifier) async {
  if (isUpdating) {
    user.updatedAt = Timestamp.now();
    await userRef.doc(user.id).update(user.toJson());
  }
  UserCredential registerResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email!.trim(), password: user.password!.trim())
      .catchError(
        // ignore: invalid_return_type_for_catch_error
        (error) => print(error.code),
      );
  user.id = registerResult.user!.uid;

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

deleteUser(UserModel user, AuthNotifier authNotifier) async {}

//=========================== INITIALIZE CURRENT USER ==========================

initializeCurrentUser(AuthNotifier? authNotifier) async {
  var appUser = FirebaseAuth.instance.currentUser;
  authNotifier!.setUser(appUser!);
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

//=================== END User =================================================

//
//============================ RESET USER PASSWORD =============================

resetUserPassword(String emailAddress) async {
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

signOutUser(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError(
        (error) => print(error.code),
      );

  authNotifier.setUser;
  const LoginUserForm();
}
