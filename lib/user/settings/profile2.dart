import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/settings/profile.dart';

class ProfileFeed extends StatefulWidget {
  const ProfileFeed({Key? key}) : super(key: key);

  @override
  _ProfileFeedState createState() => _ProfileFeedState();
}

class _ProfileFeedState extends State<ProfileFeed> {
  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    // fetchSacco(saccoNotifier, authNotifier.user!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModelNotifier authNotifier =
        Provider.of<UserModelNotifier>(context, listen: false);
    AuthNotifier currentNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    Future _refreshList() async {
      fetchUser(authNotifier, currentNotifier.user!.uid.toString());
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('User Feed'),
      //   centerTitle: true,
      //   backgroundColor: Colors.pink,
      //   actions: [],
      // ),
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  authNotifier.userList[index].firstname.toString(),
                  style: TextStyle(color: Colors.black),
                ),
                subtitle:
                    Text(authNotifier.userList[index].lastname.toString()),
                leading: Text(authNotifier.userList[index].email.toString()),
                trailing:
                    Text(authNotifier.userList[index].phonenumber.toString()),
                onTap: () {
                  authNotifier.currentUser = authNotifier.userList[index];
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
            itemCount: authNotifier.userList.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.black,
              );
            },
          ),
        ),
      ),
    );
  }

  // Widget saccoGrid() {
  //   SaccoNotifier saccoNotifier =
  //       Provider.of<SaccoNotifier>(context, listen: false);

  //   return GridView.builder(
  //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  //         maxCrossAxisExtent: 200,
  //         childAspectRatio: 3 / 2,
  //         crossAxisSpacing: 20,
  //         mainAxisSpacing: 20),
  //     itemCount: saccoNotifier.saccoList.length,
  //     itemBuilder: (BuildContext ctx, index) {
  //       return Container(
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //               color: Colors.pink[100],
  //               borderRadius: BorderRadius.circular(15)),
  //           child: ListTile(
  //             title: Text(saccoNotifier.saccoList[index].saccoName.toString(),
  //                 style: const TextStyle(fontSize: 12)),
  //             subtitle:
  //                 Text(saccoNotifier.saccoList[index].aboutSacco.toString()),
  //             leading: const Icon(
  //               Icons.image_rounded,
  //               size: 35,
  //             ),
  //             trailing: Text(saccoNotifier.saccoList[index].purpose.toString()),
  //             onTap: () {
  //               saccoNotifier.currentSacco = saccoNotifier.saccoList[index];
  //               Navigator.of(context).push(
  //                 MaterialPageRoute(
  //                   builder: (BuildContext context) {
  //                     return const SaccoDetails();
  //                   },
  //                 ),
  //               );
  //             },
  //           ));
  //     },
  // );
  // }
}
