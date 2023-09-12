import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:saccofy/sacco/deposit/notifier/deposit_notifier.dart';
import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/loan_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/loan_request_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/member_approval_notifier.dart';

import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/state/auth_state_redirect.dart';

import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_notifier.dart';

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
        ChangeNotifierProvider(
          create: (_) => UserNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => DepositNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoanRequestNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoanNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => MemberApprovalNotifier(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthStateScreen(),
      ),
    );
  }
}
