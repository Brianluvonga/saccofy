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
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_notifier.dart';

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
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    getSaccoMembers(
        memberNotifier, saccoNotifier.currentSacco.saccoId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);

    Future refreshList() async {
      getSaccoMembers(
          memberNotifier, saccoNotifier.currentSacco.saccoId.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Member Feed',
          style: TextStyle(fontFamily: 'times', fontSize: 12),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1c3751),
        actions: const [],
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

    return SingleChildScrollView(
      // scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          memberNotifier.memberList.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  memberNotifier.currentMember =
                      memberNotifier.memberList[index];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const MemberDetails();
                      },
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipOval(
                        child: Image.network(
                          memberNotifier.memberList[index].profilePic
                              .toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      memberNotifier.memberList[index].firstname.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget memberFeedCard2() {
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 65,
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
            leading: Container(
              width: 40,
              height: 40,
              child: ClipOval(
                child: Image.network(
                  memberNotifier.memberList[index].profilePic.toString(),
                  fit: BoxFit.cover,
                ),
              ),
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
