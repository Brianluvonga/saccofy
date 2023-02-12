import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUser extends StatefulWidget {
  final bool isUpdating;
  const RegisterUser({required this.isUpdating});

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
  TextEditingController profileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: prefer_final_fields
  UserModel _user = UserModel();
  bool isUpdating = false;

  //
  File? _image;
  // String? profileImageUrl;
  // Future<void> fetchImage(String userId) async {
  //   final ref = FirebaseStorage.instance.ref().child('profilePics/$userId.jpg');
  //   try {
  //     final url = await ref.getDownloadURL();
  //     setState(() {
  //       _image = url as File?;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    UserModelNotifier authNotifier =
        Provider.of<UserModelNotifier>(context, listen: false);
    // fetchImage(authNotifier.currentUser.id.toString());

    // ignore: unrelated_type_equality_checks
    if (authNotifier.currentUser != false) {
      _user = authNotifier.currentUser;
    } else {
      _user = UserModel();
    }
  }

  final picker = ImagePicker();

  Future pickImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Widget profilePic() {
    if (widget.isUpdating) {
      _image = File(_user.profilePic!.toString());
    }

    return CircleAvatar(
      radius: 30,
      backgroundColor: const Color(0xff1c3751),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: _image != null
                ? FileImage(_image!, scale: 2)
                : const NetworkImage(
                    "https://via.placeholder.com/150",
                  ) as ImageProvider<Object>,
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () async {
            await pickImage();
          },
          child: _image == null
              ? const Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 20.0,
                )
              : Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _image != null
                          ? NetworkImage(
                              _user.profilePic.toString(),
                            ) as ImageProvider<Object>
                          : FileImage(_image!, scale: 2),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

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
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Firstname',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        initialValue: _user.firstname,
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        // controller: fnameController,
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
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Lastname',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        initialValue: _user.lastname,
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        // controller: lnameController,
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

  bool _isPasswordVisible = true;

  Widget password() {
    return Container(
      width: 270,
      child: TextFormField(
        obscureText: _isPasswordVisible,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: 'Password',
          enabledBorder: const OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
          ),
          focusedBorder: const OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
          ),
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          // hintText: 'Description',
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelStyle: const TextStyle(color: Colors.black),
          suffixIcon: IconButton(
            icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.black),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),

        initialValue: _user.password,
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        // controller: passwordController,
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
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            // hintText: 'Email',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        initialValue: _user.email,
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        // controller: emailController,
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

  Widget yob() {
    return SizedBox(
      width: 270,
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Year Of Birth',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            // hintText: 'Email',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        initialValue: _user.yob,
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'YOB required';
          }
          return null;
        },
        onSaved: (String? value) {
          _user.yob = value!;
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
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            // hintText: 'Location',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        initialValue: _user.idno,
        keyboardType: TextInputType.number,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        // controller: idnoController,
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
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            // hintText: 'Location',

            labelStyle: TextStyle(color: Colors.black)),
        initialValue: _user.phonenumber,
        keyboardType: TextInputType.number,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        // controller: telController,
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
    if (widget.isUpdating) {
      dropdownValue = _user.gender;
    }
    return SizedBox(
      width: 270,
      height: 55,
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
          ),
          focusedBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Color(0xff1c3751)),
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

  bool isLoading = false;

  Future<void> registerUserToApp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState!.save();
      UserNotifier authNotifier =
          Provider.of<UserNotifier>(context, listen: false);
      try {
        await registerUserTwo(
            _user, widget.isUpdating, _image!, context, authNotifier);
        setState(() {
          isLoading = false;
        });
        if (!widget.isUpdating) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
              content: Text("Registration Successful", style: TextStyle()),
            ),
          );
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              // ignore: prefer_const_constructors
              builder: (context) => LoginUserForm(),
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Updated Personal Details Successfully '),
              backgroundColor: Colors.black,
            ),
          );
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration Not Successful: $e'),
            backgroundColor: Colors.black,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isUpdating ? "Edit Profile" : "Sign Up",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1c3751),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xff1c3751),
              ),
            )
          : form(),
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
            height: 650,
            child: Card(
              shadowColor: const Color(0xff1c3751),
              elevation: 8.0,
              // color: Color(0xff1c3751)[100],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 32, 0),
                child: Stack(
                  children: [
                    Positioned(
                      left: 115,
                      top: 0,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          profilePic(),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 70,
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
                      top: 220,
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
                      top: 290,
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
                      top: 360,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    yob(),
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
                      top: 430,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Visibility(
                                      visible: !widget.isUpdating,
                                      child: password(),
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
                      left: 70,
                      top: 510,
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: const Color(0xff1c3751),
                        child: MaterialButton(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                          minWidth: 150,
                          onPressed: () {
                            registerUserToApp();
                          },
                          child: Text(
                            widget.isUpdating ? "Edit" : "Sign Up",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Positioned(
                      left: 30,
                      top: 540,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    widget.isUpdating
                                        ? updating()
                                        : notAccomplished(),
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

  Widget updating() {
    return Container();
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
