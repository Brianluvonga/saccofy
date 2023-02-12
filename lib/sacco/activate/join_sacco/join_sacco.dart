import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_notifier.dart';

class JoinSaccoScreen extends StatefulWidget {
  const JoinSaccoScreen({Key? key}) : super(key: key);

  @override
  State<JoinSaccoScreen> createState() => _JoinSaccoScreenState();
}

class _JoinSaccoScreenState extends State<JoinSaccoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Sacco sacco = Sacco();
  TextEditingController saccoId = TextEditingController();

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  joinASacco() {
    if (!_formKey.currentState!.validate()) {
      return false;
    } else {
      _formKey.currentState!.save();

      var auth = FirebaseAuth.instance.currentUser;
      print(auth!.uid);

      joinSacco(auth.uid, sacco.saccoId.toString());
      setState(() {
        isJoining = true;
        print('joining sacco');
      });
      return true;
    }
  }

  bool isJoining = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff1c3751),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1c3751),
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Join Sacco",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        body: isJoining
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xff1c3751),
                ),
              )
            : Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: SizedBox(
                        width: 350,
                        height: 280,
                        child: Card(
                          // shadowColor: Colors.pink[300],
                          elevation: 8.0,
                          color: const Color(0xff1c3751),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 20, 32, 0),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 20,
                                  top: 0,
                                  child: Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                                joinForm(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 90,
                                  top: 130,
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.white,
                                    child: MaterialButton(
                                      padding: const EdgeInsets.fromLTRB(
                                          12.0, 10.0, 12.0, 10),
                                      minWidth: 120,
                                      onPressed: () => joinASacco(),
                                      child: const Text(
                                        'Join Sacco',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: 'times'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget joinForm() {
    return SizedBox(
      width: 250,
      child: TextFormField(
        decoration: const InputDecoration(
            // labelText: 'Sacco Invitation Link',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.white70),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.white70),
            ),
            fillColor: Color(0xff1c3751),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            labelText: 'Sacco Invitation Link',
            hintStyle: TextStyle(color: Colors.white),
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.white)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.white, fontFamily: 'times'),
        cursorColor: Colors.white,
        // controller: saccoId,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Sacco Code Required';
          }
          return null;
        },
        onSaved: (value) {
          sacco.saccoId = value;
        },
      ),
    );
  }
}
