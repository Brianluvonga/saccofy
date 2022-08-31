import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserGoogleProvider extends ChangeNotifier {
  GoogleSignIn? userSignInWithGoogle;

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  googleSignIn() async {
    final googleUser = await userSignInWithGoogle!.signIn();
    if (googleUser == null) return;
    _user = googleUser; //instance of GoogleSignIn

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  logGoogleUserOut() async {
    await userSignInWithGoogle!.disconnect();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
