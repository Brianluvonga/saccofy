import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/activate/create_sacco/activate_sacco.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';
import 'package:saccofy/sacco/details/member/view_member_details.dart';
import 'package:saccofy/sacco/details/sacco_details.dart';
import 'package:saccofy/sacco/details/sacco_infomation.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';

class MemberFeed extends StatefulWidget {
  const MemberFeed({Key? key, this.callBack}) : super(key: key);
  final Function()? callBack;

  @override
  // ignore: library_private_types_in_public_api
  _MemberFeedState createState() => _MemberFeedState();
}

class _MemberFeedState extends State<MemberFeed> {
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
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    Future refreshList() async {
      getSaccoMembers(memberNotifier, authNotifier.user!.uid);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Feed'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [],
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: memberFeedCard(),
        ),
      ),
    );
  }

  Widget memberFeedCard() {
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 75,
          mainAxisSpacing: 75),
      itemCount: memberNotifier.memberList.length,
      itemBuilder: (BuildContext ctx, index) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.pink[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            title: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          memberNotifier.memberList[index].firstname.toString(),
                          style: const TextStyle(fontSize: 9),
                        ),
                        Text(
                          memberNotifier.memberList[index].lastname.toString(),
                          style: const TextStyle(fontSize: 9),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      memberNotifier.memberList[index].email.toString(),
                      style: const TextStyle(fontSize: 9),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      memberNotifier.memberList[index].gender.toString(),
                      style: const TextStyle(fontSize: 9),
                    ),
                  ],
                ),
              ),
            ),

            // subtitle:
            //     Text(memberNotifier.memberList[index].lastname.toString()),
            leading: const Icon(
              Icons.image_rounded,
              size: 35,
            ),
            // trailing: Text(memberNotifier.memberList[index].email.toString()),
            onTap: () {
              memberNotifier.currentMember = memberNotifier.memberList[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const MemberDetails();
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
