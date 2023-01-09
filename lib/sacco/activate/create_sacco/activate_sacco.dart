import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

class ActivateSacco extends StatefulWidget {
  final bool isUpdating;
  ActivateSacco({Key? key, required this.isUpdating}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ActivateSaccoState createState() => _ActivateSaccoState();
}

class _ActivateSaccoState extends State<ActivateSacco> {
  TextEditingController businessCategoryController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Sacco? sacco;
  @override
  void initState() {
    super.initState();
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);

    // ignore: unrelated_type_equality_checks
    if (saccoNotifier.currentSacco != false) {
      sacco = saccoNotifier.currentSacco;
    } else {
      sacco = Sacco();
    }
  }

  @override
  void dispose() {
    if (mounted) {
      // Cancel any active work here
    }
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  Widget saccoName() {
    return Container(
      width: 150,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          labelText: 'Sacco Name',
          enabledBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          hintText: 'Name',
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelStyle: TextStyle(color: Colors.black),
        ),
        initialValue: sacco!.saccoName,
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          sacco!.saccoName = value;
        },
      ),
    );
  }

  Widget type() {
    return Container(
      width: 120,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            labelText: 'Type',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Type',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        initialValue: sacco!.type,
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          sacco!.type = value;
        },
      ),
    );
  }

  Widget period() {
    return Container(
      width: 120,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            labelText: 'Duration',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Duration',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black)),
        initialValue: sacco!.period,
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          sacco!.period = value;
        },
      ),
    );
  }

  Widget termsAndConditions() {
    return Container(
        width: 280,
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'Terms & Conditions',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            // hintText: 'Description',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: TextStyle(color: Colors.black),
          ),
          initialValue: sacco!.termconditions,
          keyboardType: TextInputType.name,
          style: const TextStyle(
              fontSize: 12, color: Colors.black, fontFamily: 'times'),
          cursorColor: Colors.black,
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          onSaved: (String? value) {
            sacco!.termconditions = value!;
          },
        ));
  }

  Widget about() {
    return SizedBox(
        width: 280,
        child: TextFormField(
          decoration: const InputDecoration(
              labelText: 'About Sacco',
              enabledBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              fillColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              filled: true,
              // hintText: 'Email',
              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              labelStyle: TextStyle(color: Colors.black)),
          initialValue: sacco!.aboutSacco,
          keyboardType: TextInputType.name,
          style: const TextStyle(
              fontSize: 12, color: Colors.black, fontFamily: 'times'),
          cursorColor: Colors.black,
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          onSaved: (String? value) {
            sacco!.aboutSacco = value!;
          },
        ));
  }

  Widget purpose() {
    return SizedBox(
      width: 150,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            hoverColor: Colors.black,
            labelText: 'Purpose',
            enabledBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            // hintText: 'Location',

            labelStyle: TextStyle(color: Colors.black)),
        initialValue: sacco!.purpose,
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          sacco!.purpose = value!;
        },
      ),
    );
  }

  String? dropdownValue;
// business type widget
  Widget roleField() {
    return SizedBox(
        width: 280,
        height: 50,
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(color: Colors.black, fontSize: 12),
              hintText: "Select Role",
              labelStyle: TextStyle(color: Colors.black)),

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
            sacco!.role = value;
          },
          elevation: 12,

          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue;
              businessCategoryController.text = dropdownValue!;
            });
          },
          items: <String>[
            'Admin',
            'Treasurer',
            'Member',
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
        ));
  }

  Future<void> saveSacco() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState!.save();

      AuthNotifier authNotifier =
          Provider.of<AuthNotifier>(context, listen: false);
      initializeCurrentUser(authNotifier);

      await createSacco(
          sacco!, widget.isUpdating, authNotifier.user!.uid, context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.isUpdating ? "Edit Sacco" : "Activate Sacco",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.pink[300],
        centerTitle: true,
      ),
      body: form(),
    );
  }

  Widget form() {
    return Center(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
              width: 360,
              height: 600,
              child: Card(
                shadowColor: Colors.pinkAccent[100],
                elevation: 8.0,
                color: Colors.white,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      saccoName(),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      type()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 120,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      about()
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
                        top: 192,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      purpose(),
                                      const SizedBox(width: 10),
                                      period()
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
                        top: 265,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[termsAndConditions()],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 335,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      // termsAndConditions(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 60,
                        top: 380,
                        child: Material(
                          elevation: 5.0,
                          shadowColor: Colors.pink[200],
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white,
                          child: MaterialButton(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                            minWidth: 200,
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              saveSacco();
                              Navigator.pop(context);
                            },
                            child: Text(
                              widget.isUpdating ? "Edit Sacco" : "Create Sacco",
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Positioned(
                      //   left: 50,
                      //   top: 490,
                      //   child: Column(
                      //     children: <Widget>[
                      //       GestureDetector(
                      //         behavior: HitTestBehavior.translucent,
                      //         child: Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceEvenly,
                      //           children: <Widget>[
                      //             Row(
                      //               children: <Widget>[
                      //                 notAccomplished(),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )),
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
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
