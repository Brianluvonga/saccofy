import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

//reset user password
Future resetPassword({required String email}) async {
  await auth
      .sendPasswordResetEmail(email: email)
      .catchError((e) => FirebaseAuthException(code: e));
  return;
}
