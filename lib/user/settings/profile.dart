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
  // @override
  // void didChangeDependencies() async {
  //   super.didChangeDependencies();
  //   currentMember = await getLoggedInUser(currentUser!.user!.uid);
  //   setState(() {});
  // }
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

  Widget profilePic() {
    UserModelNotifier? currentUser =
        Provider.of<UserModelNotifier?>(context, listen: false);
    return GestureDetector(
      child: CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(
          currentUser!.currentUser.profilePic!,
        ),
        // child: IconButton(
        //   icon: Icon(Icons.edit),
        //   onPressed: () {},
        // ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                width: 400,
                height: 400,
                child: Image.network(
                  currentUser.currentUser.profilePic.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget firstname() {
    UserModelNotifier? currentUser =
        Provider.of<UserModelNotifier?>(context, listen: false);
    return Card(
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      // shadowColor: Colors.grey,
      child: Container(
          height: 100,
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
                    leading: const Icon(Icons.person, color: Colors.grey),
                    title: const Text(
                      "Username",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    subtitle: Text(
                      "${currentUser!.currentUser.firstname!} ${currentUser.currentUser.lastname!}",
                      // '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
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
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      // shadowColor: Colors.grey,
      child: Container(
          height: 100,
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
                    leading:
                        const Icon(Icons.email_rounded, color: Colors.grey),
                    title: const Text(
                      "Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    subtitle: Text(
                      currentUser!.currentUser.email!,

                      // fetch from database
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
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
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      // shadowColor: Colors.grey,
      child: Container(
        height: 100,
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
                  leading:
                      const Icon(Icons.card_membership, color: Colors.grey),
                  title: const Text(
                    "ID NO",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  subtitle: Text(
                    currentUser!.currentUser.idno.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  onTap: () {},
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
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      // shadowColor: Colors.grey,
      child: Container(
        height: 100,
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
                  leading: const Icon(Icons.supervisor_account_rounded,
                      color: Colors.grey),
                  title: const Text(
                    "Gender",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  subtitle: Text(
                    currentUser!.currentUser.gender!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
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
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      // shadowColor: Colors.grey,
      child: Container(
        height: 100,
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
                  leading: const Icon(Icons.phone, color: Colors.grey),
                  title: const Text(
                    "Phone No",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  subtitle: Text(
                    currentUser!.currentUser.phonenumber!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const RegisterUser(
                          isUpdating: true,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget yob() {
    UserModelNotifier? currentUser =
        Provider.of<UserModelNotifier?>(context, listen: false);
    return Card(
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      // shadowColor: Colors.grey,
      child: Container(
          height: 100,
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
                    leading: const Icon(Icons.info_outline, color: Colors.grey),
                    title: const Text(
                      "Year Of Birth",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    subtitle: Text(
                      currentUser!.currentUser.yob.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
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
      backgroundColor: const Color(0xff1c3751),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Profile',
          style:
              TextStyle(color: Colors.white, fontFamily: 'times', fontSize: 14),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1c3751),
        actions: [
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
                color: const Color.fromARGB(255, 25, 48, 71),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    height: 25.0,
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text("Edit Profile", style: TextStyle(fontSize: 10))
                      ],
                    ),
                  ),
                  // PopupMenuItem<int>(
                  //   height: 25.0,
                  //   value: 0,
                  //   child: Row(
                  //     children: const [
                  //       Icon(
                  //         Icons.edit,
                  //         color: Colors.red,
                  //         size: 15,
                  //       ),
                  //       SizedBox(
                  //         width: 7,
                  //       ),
                  //       Text("Log Out", style: TextStyle(fontSize: 10))
                  //     ],
                  //   ),
                  // ),
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
            top: 400,
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
                          yob(),
                          idno(),
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
            top: 270,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        gender(),
                        phoneNumber(),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 20,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        profilePic(),
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

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
