import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

class AddMemberToSacco extends StatefulWidget {
  const AddMemberToSacco({super.key});

  @override
  State<AddMemberToSacco> createState() => _AddMemberToSaccoState();
}

class _AddMemberToSaccoState extends State<AddMemberToSacco> {
  //

  UserModel addUser = UserModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c3751),
      ),
      body: isAddingMember
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xff1c3751),
              ),
            )
          : form(),
    );
  }

  Widget addMemberEmailAddress() {
    return SizedBox(
      width: 250,
      height: 50,
      child: TextFormField(
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.group_add_outlined,
              size: 16,
              color: Colors.pink[300],
            ),
            // labelText: 'Member Email Address',
            enabledBorder: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            focusedBorder: const OutlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(32.0)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            hintText: 'Email Address ',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelStyle: const TextStyle(color: Colors.black)),
        keyboardType: TextInputType.name,
        style: const TextStyle(
            fontSize: 10, color: Colors.black, fontFamily: 'times'),
        cursorColor: Colors.black,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onSaved: (String? value) {
          addUser.email = value;
        },
      ),
    );
  }

  bool isAddingMember = false;

  // action done by any member in the sacco
  addMember() async {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() {
        isAddingMember = true;
      });

      try {
        _formKey.currentState!.save();

        String addUserMessage = await addUserToSacco(addUser.email.toString(),
            saccoNotifier.currentSacco.saccoId.toString());

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 5),
            backgroundColor:
                (addUserMessage == "Successfully added user to the Sacco")
                    ? Colors.green
                    : Colors.red,
            content: Text(addUserMessage, style: const TextStyle()),
          ),
        );
        if (addUserMessage == "Successfully added user to the Sacco") {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      } catch (e) {
        print(e); // Print the exception message for debugging

      } finally {
        setState(
          () {
            isAddingMember = false;
          },
        );
      }
    }
  }

  Widget form() {
    return Center(
      child: Form(
        // ignore: deprecated_member_use
        autovalidateMode: AutovalidateMode.always, key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 350,
            height: 250,
            child: Card(
              shadowColor: const Color(0xff1c3751),
              elevation: 8.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 32, 0),
                child: Stack(
                  children: [
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
                                    addMemberEmailAddress(),
                                    const SizedBox(
                                      width: 10,
                                    ),
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
                      top: 120,
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: const Color(0xff1c3751),
                        child: MaterialButton(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                          minWidth: 150,
                          onPressed: () => addMember(),
                          child: const Text(
                            'add',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.white),
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
    );
  }
}
