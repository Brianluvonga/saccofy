import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/user/account/register.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
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

  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RegisterUser(
              isUpdating: true,
            ),
          ),
        );
        break;
    }
  }

  Widget firstname() {
    UserModelNotifier? currentUser =
        Provider.of<UserModelNotifier?>(context, listen: false);
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
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: Text(
                      "${currentUser!.currentUser.firstname!} ${currentUser.currentUser.lastname!}",
                      // '',
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
                ],
              ),
            ),
          )),
    );
  }

  Widget userEmail() {
    UserModelNotifier? currentUser =
        Provider.of<UserModelNotifier?>(context, listen: false);
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
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: Text(
                      currentUser!.currentUser.email!,

                      // fetch from database
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 10),
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
                ],
              ),
            ),
          )),
    );
  }

  Widget idno() {
    UserModelNotifier? currentUser =
        Provider.of<UserModelNotifier?>(context, listen: false);
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 120,
        width: 325,
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
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Text(
                    currentUser!.currentUser.idno.toString(),

                    // '',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gender() {
    UserModelNotifier? currentUser =
        Provider.of<UserModelNotifier?>(context, listen: false);
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
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Text(
                    currentUser!.currentUser.gender!,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneNumber() {
    UserModelNotifier? currentUser =
        Provider.of<UserModelNotifier?>(context, listen: false);
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
          width: 170,
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
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: Text(
                      currentUser!.currentUser.phonenumber!,
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
                ],
              ),
            ),
          )),
    );
  }

  Widget about() {
    UserModelNotifier? currentUser =
        Provider.of<UserModelNotifier?>(context, listen: false);
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
          width: 325,
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
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: Text(
                      // currentUser!.currentUser.!,
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
        actions: [
          const Icon(Icons.more_vert, color: Colors.black),
          Theme(
            data: Theme.of(context).copyWith(
                textTheme: const TextTheme().apply(bodyColor: Colors.black),
                dividerColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.white)),
            child: Container(
              height: 5,
              child: PopupMenuButton<int>(
                constraints: const BoxConstraints(
                  minHeight: 10,
                  maxHeight: 250,
                ),
                color: Colors.pink[200],
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      height: 25.0,
                      value: 0,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.edit,
                            color: Colors.red,
                            size: 15,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text("Edit Profile", style: TextStyle(fontSize: 10))
                        ],
                      )),
                ],
                onSelected: (item) => selectedItem(context, item),
              ),
            ),
          )
        ],
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
                      Row(
                        children: <Widget>[
                          about(),
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
                      Row(children: <Widget>[
                        idno(),
                      ]),
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

  Widget editProfileElement() {
    return Container();
  }
}
