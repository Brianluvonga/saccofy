import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

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
      return;
    } else {
      _formKey.currentState!.save();

      AuthNotifier authNotifier =
          Provider.of<AuthNotifier>(context, listen: false);
      initializeCurrentUser(authNotifier);

      joinSacco(authNotifier.user!.uid, saccoId.text.toString());
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const Navigation(),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 800,
            title: const Text(
              "Join Sacco Section",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: SizedBox(
                    width: 350,
                    height: 300,
                    child: Card(
                      // shadowColor: Colors.pink[300],
                      elevation: 8.0,
                      color: Colors.pink[300],
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
                              left: 70,
                              top: 140,
                              child: Material(
                                elevation: 5.0,
                                shadowColor: Colors.pink[200],
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.pink,
                                child: MaterialButton(
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 10.0, 15.0, 10),
                                  minWidth: 150,
                                  onPressed: () => joinASacco(),
                                  child: const Text(
                                    'Join Sacco',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
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
        ));
  }

  Widget joinForm() {
    return SizedBox(
      width: 250,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
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
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Sacco Invitation Link',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        controller: saccoId,
        // validator: (String? value) {
        //   if (value!.isEmpty) {
        //     return 'Sacco Link required';
        //   }
        //   return null;
        // },
        onSaved: (String? value) {
          sacco.saccoId = value!;
        },
      ),
    );
  }
}
