import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/activate/create_sacco/activate_sacco.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/details/member/member_feed.dart';
import 'package:saccofy/sacco/details/sacco_details.dart';
import 'package:saccofy/sacco/details/sacco_infomation.dart';
import 'package:saccofy/sacco/models/create_sacco_model.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

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
    fetchSacco(saccoNotifier, authNotifier.user!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    // final currentMember = FirebaseAuth.instance.currentUser;

    var saccoInfo =
        FirebaseFirestore.instance.collection('users').doc(sacco.saccoId);

    Future refreshList() async {
      fetchSacco(saccoNotifier, saccoInfo.toString());
      // getSaccoMembers();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sacco'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [],
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: saccoGrid(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // saccoNotifier.currentSacco = null;
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return ActivateSacco(isUpdating: false);
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
    );
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
              color: Colors.pink[100], borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            title: Text(saccoNotifier.saccoList[index].saccoName.toString(),
                style: const TextStyle(fontSize: 12)),
            subtitle:
                Text(saccoNotifier.saccoList[index].aboutSacco.toString()),
            leading: const Icon(
              Icons.image_rounded,
              size: 35,
            ),
            trailing: Text(saccoNotifier.saccoList[index].purpose.toString()),
            onTap: () {
              saccoNotifier.currentSacco = saccoNotifier.saccoList[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const SaccoDetails();
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
