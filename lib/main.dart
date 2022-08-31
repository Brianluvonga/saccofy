import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/navigation/navigation.dart';

import 'package:saccofy/sacco/details/member/view_member_details.dart';

import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/state/auth_state_redirect.dart';
import 'package:saccofy/user/account/login.dart';

import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

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
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthStateScreen(),
      ),
    );
  }
}
