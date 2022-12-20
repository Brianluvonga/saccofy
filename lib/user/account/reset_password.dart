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
    if (authNotifier.user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red[600],
          content: const Text("Password Reset Link Has Sent To Your Email",
              style: TextStyle()),
        ),
      );
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[300],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pink[300],
          title: const Text(
            'Forgot Password',
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: Form(
          key: formKey,
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              components()
            ],
          )),
        ),
      ),
    );
  }

  Widget components() {
    return Card(
      elevation: 15,
      shadowColor: Colors.pink[200],
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
                  color: Colors.pink[400],
                  child: MaterialButton(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                    minWidth: 110,
                    onPressed: () async {
                      passReset();
                    },
                    child: const Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white),
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

  Widget resetPasswordHeader() {
    return const Center(
      child: Text(
        'Reset Your Password ',
        style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
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
