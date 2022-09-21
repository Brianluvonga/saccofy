import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/activate/create_sacco/activate_sacco.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

class AddSacco extends StatefulWidget {
  const AddSacco({Key? key}) : super(key: key);

  @override
  State<AddSacco> createState() => _AddSaccoState();
}

class _AddSaccoState extends State<AddSacco> {
  @override
  Widget build(BuildContext context) {
    //initializeCurrentUser
    //
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Sacco"),
          centerTitle: true,
          backgroundColor: Colors.pink[300],
        ),
        body: const Center(),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const ActivateSacco(
                  isUpdating: false,
                );
              }),
            );
          },
          foregroundColor: Colors.pink,
          backgroundColor: Colors.white,
          elevation: 15,
          child: const Icon(
            Icons.add,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
