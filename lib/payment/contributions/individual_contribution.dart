import 'package:flutter/material.dart';

class SaccoIndividualPaymentContributions extends StatefulWidget {
  const SaccoIndividualPaymentContributions({Key? key}) : super(key: key);

  @override
  _SaccoIndividualPaymentContributionsState createState() =>
      _SaccoIndividualPaymentContributionsState();
}

class _SaccoIndividualPaymentContributionsState
    extends State<SaccoIndividualPaymentContributions> {
  // settings widget cards

  Widget memberInfoCard() {
    return Card(
      color: Colors.pink[100],
      child: Container(
          height: 120,
          width: 300,
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
                      "",
                      textAlign: TextAlign.left,
                      textScaleFactor: 1,
                    ),

                    subtitle: const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and",
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

  Widget memberContributionCard() {
    return Card(
      color: Colors.white,
      child: Container(
          height: 100,
          width: 370,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: <Widget>[
                  DataTable(
                    columnSpacing: 40,
                    columns: const [
                      DataColumn(
                          label: Text('Name', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Email', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Month', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Mode', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Amount', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label:
                              Text('Approval', style: TextStyle(fontSize: 8))),
                    ],
                    rows: const [],
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
          'Individual Sacco Finances',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert_outlined, color: Colors.black),
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
            top: 80,
            left: 18,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          memberContributionCard(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 220,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          memberInfoCard(),
                        ],
                      ),
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
