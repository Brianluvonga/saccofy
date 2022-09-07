import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/activate/create_sacco/activate_sacco.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/details/sacco_details.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/sacco/pages/home/home5.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

class SaccoFeed extends StatefulWidget {
  const SaccoFeed({Key? key}) : super(key: key);

  @override
  _SaccoFeedState createState() => _SaccoFeedState();
}

class _SaccoFeedState extends State<SaccoFeed> {
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

    Future _refreshList() async {
      fetchSacco(saccoNotifier, authNotifier.user!.uid.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sacco'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [],
      ),
      body: RefreshIndicator(
          onRefresh: _refreshList,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: saccoGrid(),
          )
          // ListView.separated(
          //   itemBuilder: (BuildContext context, int index) {
          //     return ListTile(
          //       title: Text(saccoNotifier.saccoList[index].saccoName.toString()),
          //       subtitle:
          //           Text(saccoNotifier.saccoList[index].aboutSacco.toString()),
          //       leading: Text(saccoNotifier.saccoList[index].type.toString()),
          //       trailing: Text(saccoNotifier.saccoList[index].purpose.toString()),
          //       onTap: () {
          //         saccoNotifier.currentSacco = saccoNotifier.saccoList[index];
          //         // Navigator.of(context).push(
          //         //   MaterialPageRoute(
          //         //     builder: (BuildContext context) {
          //         //       return AssetDetails();
          //         //     },
          //         //   ),
          //         // );
          //       },
          //     );
          //   },
          //   itemCount: saccoNotifier.saccoList.length,
          //   separatorBuilder: (BuildContext context, int index) {
          //     return const Divider(
          //       color: Colors.black,
          //     );
          //   },
          // ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return const ActivateSacco();
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
                color: Colors.amber, borderRadius: BorderRadius.circular(15)),
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
                      return const DesignCourseHomeScreen();
                    },
                  ),
                );
              },
            ));
      },
    );
  }
}
