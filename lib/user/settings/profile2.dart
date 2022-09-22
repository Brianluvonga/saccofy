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
                  style: const TextStyle(fontSize: 10),
                ),
                subtitle: Text(authNotifier.userList[index].lastname.toString(),
                    style: const TextStyle(fontSize: 10)),
                leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg'),
                ),
                trailing: Column(
                  children: [
                    Text(
                      authNotifier.userList[index].phonenumber.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      authNotifier.userList[index].email.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {},
                      child: const Icon(Icons.edit),
                    )
                  ],
                ),
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
}
