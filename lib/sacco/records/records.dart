import 'package:flutter/material.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  // settings widget cards

  Widget saccoMembers() {
    return Card(
      color: Colors.pink[100],
      child: Container(
          height: 100,
          width: 310,
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
                    leading: const Icon(Icons.supervisor_account_rounded,
                        color: Colors.white),
                    title: const Text(
                      "Sacco Members",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: const Text(
                      "",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 15),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )),
      elevation: 8.0,
      shadowColor: Colors.black,
    );
  }

  Widget saccoSavings() {
    return Card(
      color: Colors.pink[100],
      child: Container(
          height: 100,
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
                    leading: Icon(Icons.savings_sharp, color: Colors.white),
                    title: const Text(
                      "Sacco Savings",
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
                ],
              ),
            ),
          )),
      elevation: 8.0,
      shadowColor: Colors.black,
    );
  }

  Widget others() {
    return Card(
      color: Colors.pink[100],
      child: Container(
          height: 100,
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
                    title: const Text(
                      "Others",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )),
      elevation: 8.0,
      shadowColor: Colors.black,
    );
  }

  Widget loans() {
    return Card(
      color: Colors.pink[100],
      child: Container(
          height: 100,
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
                    leading: Icon(Icons.money_off_csred_outlined,
                        color: Colors.white),
                    title: const Text(
                      "Loans",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )),
      elevation: 8.0,
      shadowColor: Colors.black,
    );
  }

  Widget notifications() {
    return Card(
      color: Colors.pink[100],
      child: Container(
          height: 100,
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
                    leading: Icon(Icons.notifications, color: Colors.white),
                    title: const Text(
                      "Notifications & Messages",
                      textAlign: TextAlign.center,
                    ),
                    subtitle: const Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff2a0404), fontSize: 12),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )),
      elevation: 8.0,
      shadowColor: Colors.black,
    );
  }

  Widget saccoDetails() {
    return Card(
      color: Colors.pink[100],
      child: Container(
          height: 100,
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
                    leading:
                        Icon(Icons.change_circle_outlined, color: Colors.white),
                    title: const Text(
                      "Sacco Details",
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
                ],
              ),
            ),
          )),
      elevation: 8.0,
      shadowColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            left: 10,
            top: 270,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[notifications()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 30,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        saccoMembers(),
                        // userEmail(),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 150,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[saccoSavings(), loans()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 52,
            top: 390,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        saccoDetails(),
                        others(),
                      ]),
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
