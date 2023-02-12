import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/user/account/register.dart';
import 'package:saccofy/user/account/reset_password.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationOn = false;
  UserModel user = UserModel();

  @override
  void initState() {
    super.initState();
    UserModelNotifier authNotifier =
        Provider.of<UserModelNotifier>(context, listen: false);
    // fetchImage(authNotifier.currentUser.id.toString());

    // ignore: unrelated_type_equality_checks
    if (authNotifier.currentUser != false) {
      user = authNotifier.currentUser;
    } else {
      user = UserModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentMember = FirebaseAuth.instance.currentUser;
    UserModelNotifier currentUser =
        Provider.of<UserModelNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xff1c3751),
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontFamily: 'times', fontSize: 18),
        ),
        backgroundColor: const Color(0xff1c3751),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(currentMember!.photoURL.toString()),
            ),
            title: const Text(
              'Account',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'times', fontSize: 13),
            ),
          ),
          InkWell(
            onTap: () {
              currentUser.currentUser = currentUser.userList[0];

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const RegisterUser(isUpdating: true),
                ),
              );
            },
            child: const ListTile(
              title: Text(
                'Edit Profile',
                style: TextStyle(
                    fontFamily: 'times', fontSize: 12, color: Colors.grey),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.grey,
                size: 17,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              currentUser.currentUser = currentUser.userList[0];

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ResetPasswordScreen(),
                ),
              );
            },
            child: const ListTile(
              title: Text(
                'Reset Password',
                style: TextStyle(
                    fontFamily: 'times', fontSize: 12, color: Colors.grey),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.grey,
                size: 17,
              ),
            ),
          ),
          const ListTile(
            title: Text(
              'Secure Account',
              style: TextStyle(
                  fontFamily: 'times', fontSize: 12, color: Colors.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 17,
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 20,
            ),
            title: Text(
              'Notifications',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'times', fontSize: 13),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isNotificationOn = !isNotificationOn;
              });
            },
            child: ListTile(
              title: const Text(
                'Notifications',
                style: TextStyle(
                    fontFamily: 'times', fontSize: 12, color: Colors.grey),
              ),
              trailing: isNotificationOn
                  // ignore: prefer_const_constructors
                  ? Icon(
                      Icons.toggle_off,
                      color: Colors.grey,
                      size: 30,
                    )
                  : const Icon(
                      Icons.toggle_on,
                      color: Colors.pink,
                      size: 30,
                    ),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(
              size: 20,
              Icons.info_outline_rounded,
              color: Colors.white,
            ),
            title: Text(
              'Other',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'times', fontSize: 13),
            ),
          ),
          const ListTile(
            title: Text(
              'Analytics',
              style: TextStyle(
                  fontFamily: 'times', fontSize: 12, color: Colors.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 17,
            ),
          ),
          const ListTile(
            title: Text(
              'Help',
              style: TextStyle(
                  fontFamily: 'times', fontSize: 12, color: Colors.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 17,
            ),
          ),
          const ListTile(
            title: Text(
              'About',
              style: TextStyle(
                  fontFamily: 'times', fontSize: 12, color: Colors.grey),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 17,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
