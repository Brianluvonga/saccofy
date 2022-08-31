import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/builders/providers/user/user_provider.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController businessCategoryController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController idnoController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController yobController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: prefer_final_fields
  UserModel _user = UserModel();

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  Widget firstname() {
    return Container(
      width: 130,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            labelText: 'Firstname',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Firstname',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        controller: fnameController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Firstname required';
          }
          return null;
        },
        onSaved: (String? value) {
          _user.firstname = value;
        },
      ),
    );
  }

  Widget lastname() {
    return Container(
      width: 130,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            labelText: 'Lastname',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Lastname',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        controller: lnameController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Lastname required';
          }
          return null;
        },
        onSaved: (String? value) {
          _user.lastname = value;
        },
      ),
    );
  }

  Widget password() {
    return Container(
      width: 270,
      child: TextFormField(
        obscureText: true,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          labelText: 'Password',
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.pink),
          ),
          focusedBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.pink),
          ),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          // hintText: 'Description',
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelStyle: TextStyle(color: Colors.black),
        ),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        controller: passwordController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Password required';
          }
          return null;
        },
        onSaved: (String? value) {
          _user.password = value!;
        },
      ),
    );
  }

  Widget email() {
    return SizedBox(
      width: 270,
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Email Address',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
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
        controller: emailController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Email Address required';
          }
          return null;
        },
        onSaved: (String? value) {
          _user.email = value!;
        },
      ),
    );
  }

  Widget idno() {
    return SizedBox(
      width: 130,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            labelText: 'ID No',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            // hintText: 'Location',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        controller: idnoController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'ID No required';
          }
          return null;
        },
        onSaved: (String? value) {
          _user.idno = value!;
        },
      ),
    );
  }

  Widget telephone() {
    return SizedBox(
      width: 130,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            hoverColor: Colors.black,
            labelText: 'Phone No',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.pink),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            // hintText: 'Location',

            labelStyle: TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        controller: telController,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Phone No required';
          }
          return null;
        },
        onSaved: (String? value) {
          _user.phonenumber = value!;
        },
      ),
    );
  }

  String? dropdownValue;
// business type widget
  Widget genderField() {
    return SizedBox(
      width: 270,
      height: 55,
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.pink),
          ),
          focusedBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.pink),
          ),
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.black, fontSize: 12),
          hintText: "Select Gender",
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),
        ),
        // itemHeight: 20.0,
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        // validator: (String? value) {
        //   if (value!.isEmpty) {
        //     return 'This field is required';
        //   }
        //   return null;
        // },
        onSaved: (String? value) {
          _user.gender = value!;
        },
        onChanged: (String? newValue) {
          setState(
            () {
              dropdownValue = newValue;
              businessCategoryController.text = dropdownValue!;
            },
          );
        },
        items: <String>[
          'Male',
          'Female',
          'Other',
        ].map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.black),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Future<void> registerUserToApp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState!.save();
      AuthNotifier authNotifier =
          Provider.of<AuthNotifier>(context, listen: false);
      registerUser(_user, authNotifier);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginUserForm(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Your Account",
          // style: TextStyle(color: Colors.pink),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[300],
      ),
      body: form(),
    );
  }

  Widget form() {
    return Center(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 350,
            height: 600,
            child: Card(
              shadowColor: Colors.pink[300],
              elevation: 8.0,
              // color: Colors.pink[100],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 32, 0),
                child: Stack(
                  children: [
                    Positioned(
                      left: 120,
                      top: 0,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    // profileImage(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 50,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    firstname(),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    lastname()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 125,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    genderField(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 200,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    telephone(),
                                    const SizedBox(width: 10),
                                    idno()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 275,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 350,
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
                      top: 440,
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,
                        child: MaterialButton(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                          minWidth: 200,
                          onPressed: () => registerUserToApp(),
                          child: const Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Positioned(
                      left: 30,
                      top: 490,
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
            MaterialPageRoute(builder: (context) => const LoginUserForm()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: 15,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
