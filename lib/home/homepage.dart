import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/deposit/functions/functions.dart';
import 'package:saccofy/sacco/details/feed/sacco_feed.dart';
import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';
import 'package:saccofy/sacco/details/member/records/member_records.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/sacco/pages/loan/loans_section.dart';
import 'package:saccofy/sacco/records/records.dart';
import 'package:saccofy/user/account/register.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';
import 'package:saccofy/home/sampleforgot.dart';
import 'package:saccofy/user/settings/profile.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  UserModel currentMember = UserModel();
  NumbersService totalDeposit = NumbersService();

  @override
  void initState() {
    UserModelNotifier currentUser =
        Provider.of<UserModelNotifier>(context, listen: false);
    User? auth = FirebaseAuth.instance.currentUser;

    fetchUser(currentUser, auth!.uid);

    super.initState();
  }

  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MemberRecords(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SaccoFeed(),
          ),
        );
        break;
      case 2:
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserModelNotifier user =
        Provider.of<UserModelNotifier>(context, listen: false);
    AuthNotifier currentUser =
        Provider.of<AuthNotifier>(context, listen: false);
    var currentMember = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xff1c3751),
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 14, fontFamily: 'times'),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1c3751),
        elevation: 0,
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
                textTheme: const TextTheme().apply(bodyColor: Colors.black),
                dividerColor: const Color.fromARGB(255, 221, 219, 219),
                iconTheme: const IconThemeData(color: Colors.white)),
            child: Container(
              height: 5,
              child: PopupMenuButton<int>(
                color: const Color.fromARGB(255, 25, 48, 71),
                constraints: const BoxConstraints(
                  minWidth: 50,
                  minHeight: 10,
                  maxHeight: 250,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    height: 25.0,
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.history_sharp,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Records",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const PopupMenuDivider(
                    height: 15,
                  ),
                  PopupMenuItem<int>(
                    height: 25.0,
                    value: 2,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.account_balance,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Savings",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                onSelected: (item) => selectedItem(context, item),
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
          // backgroundColor: const Color(0xff1c3751),
          child: ListView(
        children: <Widget>[
          Container(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Center(
                child: DrawerHeader(
                    // margin: EdgeInsets.only(top: 10, bottom: 0),
                    decoration: const BoxDecoration(
                        // color: Colors.white,
                        ),
                    child: FutureBuilder(
                        future: fetchUser(user, currentMember!.uid),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xff1c3751),
                              ),
                            );
                          } else {
                            if (snapshot.hasError) {
                              return const Center(child: Text('Error'));
                            } else {
                              return userDetails();
                            }
                          }
                        }))),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.payments,
              size: 20,
              color: Color(0xff1c3751),
            ),
            title: const Text(
              'Payment',
              style: TextStyle(
                  fontFamily: 'times',
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              // Perform some action when item 1 is tapped
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.credit_score,
              size: 20,
              color: Color(0xff1c3751),
            ),
            title: const Text(
              'Saccos',
              style: TextStyle(
                  fontFamily: 'times',
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const SaccoFeed();
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.help_rounded,
              size: 20,
              color: Color(0xff1c3751),
            ),
            title: const Text(
              'Help',
              style: TextStyle(
                  fontFamily: 'times',
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              // Perform some action when item 2 is tapped
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.info_outline_rounded,
              size: 20,
              color: Color(0xff1c3751),
            ),
            title: const Text(
              'About',
              style: TextStyle(
                  fontFamily: 'times',
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              // Perform some action when item 2 is tapped
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 20,
              color: Color(0xff1c3751),
            ),
            title: const Text(
              'Log Out',
              style: TextStyle(
                  fontFamily: 'times',
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            onTap: () {
              signOutUser(currentUser, context, currentMember.uid);
            },
          ),
        ],
      )),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            top: 20,
            // right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          welcomeMsg(),
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
            top: 230,
            right: 2,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(children: <Widget>[
                      saccos(),
                      const SizedBox(
                        width: 10,
                      ),
                      loans(),
                    ]),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 60,
            right: 10,
            child: totalContributionsCard(),
          ),
          Positioned(
            left: 0,
            top: 400,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        personalUserSavings(),
                        const SizedBox(
                          width: 10,
                        ),
                        notifications()
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

  Widget saccos() {
    var currentMember = FirebaseAuth.instance.currentUser;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 1, 18, 32),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Saccos",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<int>(
                future: getUserNumberOfSaccos(currentMember!.uid),
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "${snapshot.data}",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else if (snapshot.data == null) {
                    return const Text("You Don't Belong To Any Sacco",
                        style: TextStyle(color: Colors.white));
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    );
                  }
                },
              )
            ],
          ),
        ),
        Positioned(
          top: 110,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all()),
            child: const Icon(
              Icons.keyboard_arrow_down,
              // color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget loans() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 1, 18, 32),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LoanScreenSection();
                  },
                ),
              );
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Loans Section",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Image.asset(
                  'images/file2.png',
                  width: 45,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget notifications() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 1, 18, 32),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              const Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc()
                    .collection('notifications')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Icon(
                      Icons.notifications,
                      size: 30,
                    );
                  }
                  int count = snapshot.data!.docs.length;
                  return Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // handle the press
                        },
                      ),
                      count != ''
                          ? Positioned(
                              right: 0,
                              top: 10,
                              child: Text(
                                count.toString(),
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget personalUserSavings() {
    var currentMember = FirebaseAuth.instance.currentUser;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 1, 18, 32),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Personal Savings",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<double>(
                future: checkPersonalSavings(currentMember!.uid),
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "${snapshot.data}",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else if (snapshot.data == null) {
                    return const Text("0",
                        style: TextStyle(color: Colors.white));
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    );
                  }
                },
              )
            ],
          ),
        ),
        Positioned(
          top: 110,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all()),
            child: const Icon(
              Icons.keyboard_arrow_down,
              // color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget totalContributionsCard() {
    var currentMember = FirebaseAuth.instance.currentUser;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 150,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 1, 18, 32),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Total Sacco Deposits",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<double>(
                future: totalDeposit.getUserTotalDeposit(currentMember!.uid),
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "${snapshot.data}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    );
                  } else if (snapshot.data == null) {
                    return const Text("0",
                        style: TextStyle(color: Colors.white));
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    );
                  }
                },
              )
            ],
          ),
        ),
        Positioned(
          top: 20,
          // left: 20,
          right: 25,
          child: Container(
            padding: const EdgeInsets.all(5),
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     shape: BoxShape.circle,
            //     border: Border.all()),
            child: const Icon(
              Icons.visibility,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 110,
          left: 20,
          right: 25,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all()),
            child: const Icon(
              Icons.keyboard_arrow_down,
              // color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget welcomeMsg() {
    UserModelNotifier currentUser =
        Provider.of<UserModelNotifier>(context, listen: false);
    var currentMember = FirebaseAuth.instance.currentUser;

    return Center(
        child: Text(
      'Welcome ${currentMember!.displayName}',
      style: const TextStyle(color: Colors.white),
    ));
  }

  Widget userDetails() {
    UserModelNotifier currentUser =
        Provider.of<UserModelNotifier>(context, listen: false);
    Future<void> refreshProfile() async {
      fetchUser(currentUser, currentUser.currentUser.id.toString());
    }

    return RefreshIndicator(
      onRefresh: refreshProfile,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              style: const TextStyle(
                fontFamily: 'times',
              ),
              '${currentUser.userList[index].firstname} ${currentUser.userList[index].lastname}',
            ),
            subtitle: Text(
              currentUser.userList[index].email.toString(),
              style: const TextStyle(fontFamily: 'times', fontSize: 12),
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage:
                  NetworkImage(currentUser.userList[0].profilePic.toString()),
            ),
            onTap: () {
              currentUser.currentUser = currentUser.userList[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const UserSettingsPage();
                  },
                ),
              );
            },
          );
        },
        itemCount: currentUser.userList.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.black,
          );
        },
      ),
    );
  }
}
