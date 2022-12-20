import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/navigation/navigation.dart';
import 'package:saccofy/payment/contributions/sacco_contribution_details.dart';
import 'package:saccofy/sacco/deposit/deposit_to_sacco.dart';
import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';

import 'package:saccofy/sacco/details/member/view_member_details.dart';
import 'package:saccofy/sacco/details/sacco_details.dart';
import 'package:saccofy/sacco/loan/application/loan_application.dart';

import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/state/auth_state_redirect.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/account/reset_password.dart';

import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/settings/profile.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => SaccoNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserModelNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => MemberNotifier(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthStateScreen(),
      ),
    );
  }
}
