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
      color: Colors.pink[100],
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
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    saccoNotifier.currentSacco.saccoName.toString(),
                    // authNotifier.user!.displayName.toString(),
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(color: Color(0xff2a0404), fontSize: 10),
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

  loginUser() {}

  Widget type() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 180,
        width: 380,
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
                left: 30,
                child: Column(
                  children: const [
                    Text(
                      'Total Contributions',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Kshs. 0',
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                right: 50,
                child: Column(
                  children: [
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(40.0),
                      color: Colors.white,
                      child: MaterialButton(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                        minWidth: 80,
                        onPressed: () => loginUser(),
                        child: const Text(
                          'Deposit',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   'Kshs. 0',
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget invitationLink() {
    return Card(
      color: Colors.pink[100],
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
                    leading: const Icon(Icons.link_sharp),
                    title: const Text(
                      "Join Link",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text(
                      '',
                      // fetch from database
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 10),
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

  Widget members() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Card(
      color: Colors.pink[100],
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
                    leading: const Icon(Icons.people_outline),
                    title: const Text(
                      "Members",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.members!.length.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff2a0404), fontSize: 10),
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

  Widget about() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Card(
      color: Colors.pink[100],
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
                    leading: const Icon(Icons.details),
                    title: const Text(
                      "About Sacco",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.aboutSacco.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff2a0404), fontSize: 10),
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
      color: Colors.pink[100],
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
                    leading: const Icon(Icons.info_outline_rounded),
                    title: const Text(
                      "Purpose",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.purpose.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff2a0404), fontSize: 10),
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
      color: Colors.pink[100],
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
                    leading: const Icon(Icons.info_outline),
                    title: const Text(
                      "Terms & Conditions",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.termconditions.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xff2a0404), fontSize: 10),
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
      color: Colors.pink[100],
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
                    leading: const Icon(Icons.savings),
                    title: const Text(
                      "Accounts & Savings",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      saccoNotifier.currentSacco.type.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: const Color(0xff2a0404), fontSize: 10),
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
    switch (item) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LoanApplicationForm()));
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ActivateSacco(
                    isUpdating: true,
                  )),
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
      appBar: AppBar(
        title: Text(
          saccoNotifier.currentSacco.saccoName.toString(),
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        centerTitle: true,
        elevation: 40,
        backgroundColor: Colors.white,
        actions: [
          const Icon(Icons.more_vert, color: Colors.black),
          Theme(
            data: Theme.of(context).copyWith(
                textTheme: const TextTheme().apply(bodyColor: Colors.black),
                dividerColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.white)),
            child: Container(
              height: 5,
              child: PopupMenuButton<int>(
                constraints: const BoxConstraints(
                  minHeight: 10,
                  maxHeight: 250,
                ),
                color: Colors.pink[200],
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      height: 25.0,
                      value: 0,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.monetization_on,
                            color: Colors.red,
                            size: 15,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text("Apply Loan", style: TextStyle(fontSize: 10))
                        ],
                      )),
                  // const PopupMenuDivider(),
                  // PopupMenuItem<int>(
                  //   height: 25.0,
                  //   value: 1,
                  //   child: Row(
                  //     children: const [
                  //       Icon(
                  //         Icons.history,
                  //         color: Colors.red,
                  //         size: 15,
                  //       ),
                  //       SizedBox(
                  //         width: 7,
                  //       ),
                  //       Text("Records", style: TextStyle(fontSize: 10))
                  //     ],
                  //   ),
                  // ),
                  const PopupMenuDivider(),
                  PopupMenuItem<int>(
                    height: 25.0,
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.red,
                          size: 15,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text("Edit Sacco", style: TextStyle(fontSize: 10))
                      ],
                    ),
                  ),
                  // const PopupMenuDivider(),
                  // PopupMenuItem<int>(
                  //     height: 25.0,
                  //     value: 2,
                  //     child: Row(
                  //       children: const [
                  //         Icon(
                  //           Icons.logout,
                  //           color: Colors.red,
                  //           size: 15,
                  //         ),
                  //         SizedBox(
                  //           width: 7,
                  //         ),
                  //         Text("Logout", style: TextStyle(fontSize: 10))
                  //       ],
                  //     )),
                ],
                onSelected: (item) => selectedItem(context, item),
              ),
            ),
          )
        ],
      ),
      // drawer: const Drawer(backgroundColor: Colors.black),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            top: 5,
            left: 10,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[type()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 5,
            top: 470,
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
            top: 200,
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
          Positioned(
            left: 50,
            top: 290,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[members()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 6,
            top: 380,
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
      ),
    );
  }
}
