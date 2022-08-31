import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/navigation/navigation.dart';
import 'package:saccofy/user/account/register.dart';
import 'package:saccofy/user/account/reset_password.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

class LoginUserForm extends StatefulWidget {
  const LoginUserForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginUserFormState createState() => _LoginUserFormState();
}

class _LoginUserFormState extends State<LoginUserForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: prefer_final_fields
  UserModel _user = UserModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //
  //

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  Future<void> _loginUserEmailAndPassword() async {
    try {
      final UserCredential user = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
      User? currentUser = user.user;
      currentUser;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red[600],
          content: const Text("Login Successful", style: TextStyle()),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Navigation(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text(
              "Login Not Successful, invalid credentials or poor internet connection"),
        ),
      );
    }
  }

  Widget email() {
    return SizedBox(
      width: 250,
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Email Address',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.pink),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.pink),
          ),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          labelStyle: TextStyle(color: Colors.black),
        ),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        controller: emailController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Your Email Address is required';
          }
          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }

          return null;
        },
        onSaved: (String? value) {
          _user.email = value!;
        },
      ),
    );
  }

  Widget password() {
    return SizedBox(
      width: 250,
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
            labelText: 'Password',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            // hintText: 'Email',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        controller: passController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          _user.password = value!;
        },
      ),
    );
  }

  Future<void> loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState!.save();

      AuthNotifier authNotifier =
          Provider.of<AuthNotifier>(context, listen: false);
      signInUser(_user, authNotifier);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Navigation(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Login",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[300],
      ),
      body: form(),
    );
  }

  Widget googleSignInButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        primary: Colors.pink,
        onPrimary: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      label: const Text(
        'Sign In with Google',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'times',
        ),
      ),
      onPressed: () {
        // signInWithGoogle().whenComplete(() {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) {
        //         return HomePage();
        //       },
        //     ),
        //   );
        // });
      },
    );
  }

  Widget form() {
    return Center(
      child: Form(
        // ignore: deprecated_member_use
        autovalidateMode: AutovalidateMode.always, key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 350,
            height: 600,
            child: Card(
              shadowColor: Colors.pink,
              elevation: 8.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 32, 0),
                child: Stack(
                  children: [
                    Positioned(
                      left: 130,
                      top: 370,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: const <Widget>[
                                    Text(
                                      "or",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'times',
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 180,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    forgotPassword(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 60,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    email(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // lastname()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 140,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    password(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 40,
                      top: 270,
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,
                        child: MaterialButton(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                          minWidth: 200,
                          onPressed: () => loginUser(),
                          child: const Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Positioned(
                      left: 20,
                      top: 450,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    notAccomplished(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget notAccomplished() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RegisterUser()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Dont have an account ?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Register',
              style: TextStyle(
                color: Colors.pink,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResetPasswordScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              '',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Forgot Password?',
              style: TextStyle(
                color: Color.fromARGB(255, 53, 50, 50),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
