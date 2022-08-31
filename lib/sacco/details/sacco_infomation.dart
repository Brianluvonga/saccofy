import 'package:flutter/material.dart';

class SaccoDetails extends StatefulWidget {
  const SaccoDetails({Key? key}) : super(key: key);

  @override
  _SaccoDetailsState createState() => _SaccoDetailsState();
}

class _SaccoDetailsState extends State<SaccoDetails> {
  // settings widget cards

  Widget sacconame() {
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
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
                      "Name",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: const Text(
                      "",
                      // authNotifier.user!.displayName.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 15),
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

  Widget type() {
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 50,
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
                    // leading: const Icon(Icons.person),
                    title: const Text(
                      "Type",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: const Text(
                      "",
                      // authNotifier.user!.displayName.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 15),
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

  Widget InvitationLink() {
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
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
                    ),
                    subtitle: const Text(
                      '',
                      // fetch from database
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
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
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
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
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
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

  Widget about() {
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
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
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
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
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
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
                    leading: const Icon(Icons.phone),
                    title: const Text(
                      "Purpose",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
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
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
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
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
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
    return Card(
      color: Colors.pink[100],
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 120,
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
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sacco Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            top: 15,
            left: 50,
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
            top: 485,
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
            top: 80,
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
                        InvitationLink(),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 50,
            top: 215,
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
            top: 350,
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
