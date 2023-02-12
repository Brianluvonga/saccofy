import 'package:flutter/material.dart';

class LoanApprovalSection extends StatefulWidget {
  const LoanApprovalSection({Key? key}) : super(key: key);

  @override
  _LoanApprovalSectionState createState() => _LoanApprovalSectionState();
}

class _LoanApprovalSectionState extends State<LoanApprovalSection> {
  // settings widget cards
  saveStartup() {}
  Widget approveButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10),
        minWidth: 150,
        onPressed: () => saveStartup(),
        child: const Text(
          'Approve',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }

  Widget declineButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xff1c3751),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10),
        minWidth: 150,
        onPressed: () => saveStartup(),
        child: const Text(
          'Reject',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget memberContributionCard() {
    return Card(
      color: Colors.white,
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
          height: 100,
          width: 380,
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
                    columnSpacing: 35,
                    columns: const [
                      DataColumn(
                          label: Text('Ref No', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('App ID', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Repay Date',
                              style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Name', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label:
                              Text('Phone No', style: TextStyle(fontSize: 8))),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Loan Request Section',
          style: TextStyle(color: Colors.black, fontSize: 14),
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
            top: 30,
            left: 12,
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
                        approveButton(),
                        SizedBox(
                          width: 10,
                        ),
                        declineButton()
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
