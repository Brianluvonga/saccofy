import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({Key? key}) : super(key: key);

  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  //
  //initializeCurrentUser

  AuthNotifier? currentUser;

  UserModel currentMember = UserModel();
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentMember = await getLoggedInUser(currentUser!.user!.uid);
    setState(() {});
  }
  // settings widget cards

  Widget firstname() {
    AuthNotifier? authNotifier =
        Provider.of<AuthNotifier?>(context, listen: false);
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(
                      "Username",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      authNotifier!.user!.displayName!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 7, 2, 7), fontSize: 10),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>

                      //   ),
                      // )
                    },
                  ),
                  const Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget userEmail() {
    AuthNotifier? authNotifier =
        Provider.of<AuthNotifier?>(context, listen: false);
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
          width: 175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.16,
            child: Center(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.email_rounded),
                    title: const Text(
                      "Email",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      authNotifier!.user!.email!,

                      // '',
                      // fetch from database
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff2a0404), fontSize: 10),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>

                      //   ),
                      // )
                    },
                  ),
                  const Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget idno() {
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.16,
            child: Center(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.card_membership),
                    title: const Text(
                      "ID NO",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      currentMember.firstname!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>

                      //   ),
                      // )
                    },
                  ),
                  const Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget gender() {
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.16,
            child: Center(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.supervisor_account_rounded),
                    title: const Text(
                      "Gender",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>

                      //   ),
                      // )
                    },
                  ),
                  const Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget phoneNumber() {
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.16,
            child: Center(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text(
                      "Phone No",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>

                      //   ),
                      // )
                    },
                  ),
                  const Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget about() {
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
          width: 310,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.16,
            child: Center(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text(
                      "About",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>

                      //   ),
                      // )
                    },
                  ),
                  const Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget location() {
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.16,
            child: Center(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text(
                      "Location",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>

                      //   ),
                      // )
                    },
                  ),
                  const Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            left: 10,
            top: 330,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[about()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 30,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        firstname(),
                        userEmail(),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 180,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[gender(), phoneNumber()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 480,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[idno(), location()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
