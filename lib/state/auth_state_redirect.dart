import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/navigation/navigation.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/account/register.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

enum AuthState {
  loggedIn,
  notLoggedIn,
  waiting,
}

class AuthStateScreen extends StatefulWidget {
  const AuthStateScreen({Key? key}) : super(key: key);

  @override
  State<AuthStateScreen> createState() => _AuthStateScreenState();
}

class _AuthStateScreenState extends State<AuthStateScreen> {
  AuthState authRedirect = AuthState.notLoggedIn;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    AuthNotifier auth = Provider.of<AuthNotifier>(context, listen: false);

    User? backString = auth.user;

    if (backString == 'sucess') {
      setState(() {
        authRedirect = AuthState.loggedIn;
      });
    }
  }

  late Widget widgetValue;

  @override
  Widget build(BuildContext context) {
    switch (authRedirect) {
      case AuthState.notLoggedIn:
        widgetValue = const LoginUserForm();
        break;
      case AuthState.loggedIn:
        widgetValue = const Navigation();
        break;
      default:
    }
    return widgetValue;
  }
}
