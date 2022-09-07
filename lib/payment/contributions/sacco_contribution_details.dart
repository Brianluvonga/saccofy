import 'package:flutter/material.dart';

class PaymentContributions extends StatefulWidget {
  const PaymentContributions({Key? key}) : super(key: key);

  @override
  _PaymentContributionsState createState() => _PaymentContributionsState();
}

class _PaymentContributionsState extends State<PaymentContributions> {
  // settings widget cards

  Widget statistics() {
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

  Widget memberContributionCard() {
    return Card(
      color: Colors.white,
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 100,
          width: 370,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.16,
            child: Center(
              child: Column(
                children: <Widget>[
                  DataTable(
                    columnSpacing: 45,
                    columns: const [
                      DataColumn(
                          label: Text('Name', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Email', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Month', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Payment_Method',
                              style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Amount', style: TextStyle(fontSize: 8))),
                    ],
                    rows: const [],
                  ),
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
          'Sacco Finances',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Colors.black),
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
            top: 15,
            left: 18,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[memberContributionCard()]),
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
                      Row(children: const <Widget>[
                        // termsAndConditions(),
                        // accountAndSavings()
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
                      Row(children: const <Widget>[
                        // sacconame(),
                        // InvitationLink(),
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
                      Row(
                        children: const <Widget>[
                          // members(),
                        ],
                      ),
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
                      Row(children: const <Widget>[
                        // about(),
                        // purpose(),
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
