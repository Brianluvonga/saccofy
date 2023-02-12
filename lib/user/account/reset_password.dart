import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // textediting handler
  TextEditingController passwordReset = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  UserModel user = UserModel();

  //
  // reset password screen function
  passReset() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    resetUserPassword(authNotifier.user!.email.toString());

    // show snackbar
    if (authNotifier.user!.email != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text(
              "Password Reset Link Has Sent To Your Email",
              style: TextStyle(fontSize: 12, fontFamily: 'times'),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text(
                  "OK",
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // redirect to login screen
                },
              ),
            ],
          );
        },
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff1c3751),
      child: Scaffold(
        // backgroundColor: const Color(0xff1c3751),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff1c3751),
          title: const Text(
            'Forgot Password',
            style: TextStyle(fontSize: 14, fontFamily: 'times'),
          ),
        ),
        body: Form(
          key: formKey,
          child: Center(
            child: components(),
          ),
        ),
      ),
    );
  }

  Widget components() {
    return Card(
      elevation: 15,
      color: const Color(0xff1c3751),
      // shadowColor: Colors.pink[200],
      child: SizedBox(
        height: 230,
        width: 350,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                emailEntry(),
                const SizedBox(
                  height: 30,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                    minWidth: 100,
                    height: 30,
                    onPressed: () async {
                      passReset();
                    },
                    child: const Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'times'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailEntry() {
    return SizedBox(
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Your Email Address',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          fillColor: Color(0xff1c3751),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          labelStyle: TextStyle(color: Colors.white),
        ),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.white,
        // controller: passwordReset,
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
          user.email = value!;
        },
      ),
    );
  }
}
