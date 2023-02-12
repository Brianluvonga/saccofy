import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/activate/create_sacco/activate_sacco.dart';
import 'package:saccofy/sacco/activate/join_sacco/join_sacco.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/details/feed/search_delegate.dart';
import 'package:saccofy/sacco/details/member/member_feed.dart';
import 'package:saccofy/sacco/details/sacco_details.dart';
import 'package:saccofy/sacco/details/sacco_infomation.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/sacco/pages/home/home.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SaccoFeed extends StatefulWidget {
  const SaccoFeed({Key? key}) : super(key: key);

  @override
  _SaccoFeedState createState() => _SaccoFeedState();
}

class _SaccoFeedState extends State<SaccoFeed> {
  Sacco sacco = Sacco();
  @override
  void initState() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    var currentMember = FirebaseAuth.instance.currentUser;
    fetchSacco(saccoNotifier, currentMember!.uid.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    var currentMember = FirebaseAuth.instance.currentUser;

    Future refreshList() async {
      fetchSacco(saccoNotifier, currentMember!.uid);
    }

    bool _showSearchBar = false;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Saccos',
            style: TextStyle(fontFamily: 'times', fontSize: 14),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff1c3751),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 20,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate:
                      SaccoSearchDelegate(saccos: saccoNotifier.saccoList),
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: refreshList,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: fetchSacco(saccoNotifier, currentMember!.uid),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xff1c3751),
                    ),
                  );
                }
                // check if snapshot.data is null
                if (snapshot.hasData && snapshot.data != null) {
                  return Center(
                    child: saccoGrid(),
                  );
                } else {
                  return const Center(
                    child: Text(
                        'You Do Not Belong To Any Sacco, Join or Create A Sacco'),
                  );
                }
              }),
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          //Speed dial menu
          icon: Icons.menu, //icon on Floating action button
          activeIcon: Icons.close, //icon when menu is expanded on button
          backgroundColor: const Color(0xff1c3751), //background color of button
          foregroundColor: Colors.white, //font color, icon color in button
          activeBackgroundColor:
              const Color(0xff1c3751), //background color when menu is expanded
          activeForegroundColor: Colors.white,
          visible: true,
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          elevation: 8.0, //shadow elevation of button
          shape: const CircleBorder(), //shape of button

          children: [
            SpeedDialChild(
              child: const Icon(Icons.join_inner_sharp),
              backgroundColor: Colors.pink[300],
              foregroundColor: Colors.white,
              label: 'Join A Sacco',
              labelStyle: const TextStyle(fontSize: 15.0),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const JoinSaccoScreen();
                    },
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.add),
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xff1c3751),
              label: 'Create Sacco',
              labelStyle: const TextStyle(fontSize: 15.0),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const ActivateSacco(
                        isUpdating: false,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat);
  }

  Widget saccoGrid() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: saccoNotifier.saccoList.length,
      itemBuilder: (BuildContext ctx, index) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 251, 253),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color.fromARGB(255, 146, 175, 202))),
          child: ListTile(
            title: Text(
                saccoNotifier.saccoList[index].saccoName
                    .toString()
                    .toUpperCase(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            subtitle: Text(
              saccoNotifier.saccoList[index].aboutSacco.toString(),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            leading: const Icon(
              Icons.change_circle_outlined,
              size: 30,
              color: Color(0xff1c3751),
            ),
            onTap: () {
              saccoNotifier.currentSacco = saccoNotifier.saccoList[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const SaccoHomePage();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
