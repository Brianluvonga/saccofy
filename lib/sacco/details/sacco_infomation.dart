import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/activate/create_sacco/activate_sacco.dart';
import 'package:saccofy/sacco/details/member/member_feed.dart';
import 'package:saccofy/sacco/loan/application/loan_application.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/sacco/records/records.dart';

class SaccoDetails extends StatefulWidget {
  const SaccoDetails({Key? key}) : super(key: key);

  @override
  _SaccoDetailsState createState() => _SaccoDetailsState();
}

class _SaccoDetailsState extends State<SaccoDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // settings widget cards

  Widget sacconame() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);

    return Card(
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 80,
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
                  // leading: const Icon(Icons.acc),
                  title: const Text(
                    "Sacco Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'times',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  subtitle: Text(
                    saccoNotifier.currentSacco.saccoName.toString(),
                    // authNotifier.user!.displayName.toString(),
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
                // Icon(Icons.edit)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget type() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Card(
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 180,
        width: 310,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
        ),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 50,
                left: 100,
                child: Center(
                  child: Column(
                    children: const [
                      Text(
                        'Total Contributions',
                        style: TextStyle(
                            fontFamily: 'times',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Kshs. 0',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget invitationLink() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Card(
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 80,
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
                    leading: const Icon(Icons.people, color: Colors.grey),
                    title: const Text(
                      "Members",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'times',
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.members.length.toString(),
                      // sacco new member can join sacco with
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                    onTap: () {
                      saccoNotifier.currentSacco = saccoNotifier.saccoList[0];
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const MemberFeed();
                        }),
                      );
                    },
                  ),
                  // Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget members() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Card(
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 80,
          width: 310,
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
                    leading: const Icon(Icons.share, color: Colors.grey),
                    title: const Text(
                      "Invite Code",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.saccoId.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    onTap: () {},
                  ),
                  // Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget about() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Card(
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 80,
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
                    leading: const Icon(Icons.details, color: Colors.grey),
                    title: const Text(
                      "About Sacco",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'times',
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.aboutSacco.toString(),
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
                  // Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget purpose() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Card(
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 80,
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
                    leading: const Icon(Icons.info_outline_rounded,
                        color: Colors.grey),
                    title: const Text(
                      "Purpose",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.purpose.toString(),
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
                  // Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget termsAndConditions() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Card(
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 80,
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
                      "Terms",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.termconditions.toString(),
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
                  // Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  Widget accountAndSavings() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Card(
      color: const Color.fromARGB(255, 25, 48, 71),
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 80,
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
                    contentPadding: const EdgeInsets.all(5),
                    leading: const Icon(Icons.savings, color: Colors.grey),
                    title: const Text(
                      "Type",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.type.toString(),
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
                  // Icon(Icons.edit)
                ],
              ),
            ),
          )),
    );
  }

  void selectedItem(BuildContext context, item) {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ActivateSacco(
              isUpdating: true,
            ),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ActivateSacco(
              isUpdating: true,
            ),
          ),
        );
        break;
      // case 2:
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(
      //         builder: (context) => ActivateSacco(
      //           isUpdating: true,
      //         ),
      //       ),
      //       (route) => false);

      //   break;
      // case 3:
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) => const Records()),
      //       (route) => false);
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color(0xff1c3751),
        appBar: AppBar(
          backgroundColor: const Color(0xff1c3751),
          title: Text(
            saccoNotifier.currentSacco.saccoName.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          centerTitle: true,
          elevation: 0,
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
                      minHeight: 10, maxHeight: 250, minWidth: 50),
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
                          Text("Edit Sacco", style: TextStyle(fontSize: 10))
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
        // drawer: const Drawer(backgroundColor: Colors.black),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('saccos').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return CircularProgressIndicator();
            return Stack(
              clipBehavior: Clip.none,
              fit: StackFit.loose,
              children: <Widget>[
                Positioned(
                  top: 30,
                  left: 50,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                type(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 430,
                  right: 2,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(children: <Widget>[
                              termsAndConditions(),
                              accountAndSavings()
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 230,
                  right: 2,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(children: <Widget>[
                              sacconame(),
                              invitationLink(),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   left: 50,
                //   top: 330,
                //   child: Column(
                //     children: <Widget>[
                //       GestureDetector(
                //         behavior: HitTestBehavior.translucent,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: <Widget>[
                //             Row(children: <Widget>[members()]),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Positioned(
                  left: 6,
                  top: 330,
                  right: 2,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(children: <Widget>[about(), purpose()]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
