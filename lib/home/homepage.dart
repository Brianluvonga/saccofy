import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/activate/create_sacco/activate_sacco.dart';
import 'package:saccofy/sacco/details/feed/sacco_feed.dart';
import 'package:saccofy/user/account/login.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/models/user_model.dart';
import 'package:saccofy/user/settings/profile.dart';
import 'package:saccofy/user/settings/profile2.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? currentMember;
  AuthNotifier? authNotifier;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentMember = await getLoggedInUser(authNotifier!.user!.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //initializeCurrentUser
    //
    AuthNotifier? authNotifier =
        Provider.of<AuthNotifier?>(context, listen: false);

    UserModelNotifier? currentUser =
        Provider.of<UserModelNotifier?>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Create Sacco"),
        // centerTitle: true,
        backgroundColor: Colors.pink[600],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const ProfileFeed()),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.red[600],
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserSettingsPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.change_circle_rounded,
                color: Colors.red[600],
              ),
              title: const Text('Sacco'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SaccoFeed(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.payments_sharp,
                color: Colors.red[600],
              ),
              title: const Text('Payments'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.red[600],
              ),
              title: const Text('Help'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red[600],
              ),
              title: const Text('Logout'),
              onTap: () {
                // signOutUser(authNotifier);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const LoginUserForm();
                  }),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 700,
            height: 700,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: const <Widget>[
                                // userSection(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: const <Widget>[],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 125,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: const <Widget>[],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 200,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: const <Widget>[],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 275,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: const <Widget>[],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 350,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: const <Widget>[],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userSection() {
    return Card(
      child: Container(
        color: Colors.black,
        height: 200,
        width: 400,
      ),
    );
  }
}
