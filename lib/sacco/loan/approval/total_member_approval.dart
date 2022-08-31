import 'package:flutter/material.dart';

class LoanApprovalNumbers extends StatefulWidget {
  const LoanApprovalNumbers({Key? key}) : super(key: key);

  @override
  _LoanApprovalNumbersState createState() => _LoanApprovalNumbersState();
}

class _LoanApprovalNumbersState extends State<LoanApprovalNumbers> {
  // settings widget cards

  Widget membersApprovalCard() {
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
                    columnSpacing: 40,
                    columns: const [
                      DataColumn(
                          label: Text('Name', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Email', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label:
                              Text('Telephone', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Status', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label:
                              Text('Phone No', style: TextStyle(fontSize: 8))),
                    ],
                    rows: const [],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget applicantsTag() {
    return const Center(
      child: Text("Applicants Details", style: TextStyle(fontSize: 12)),
    );
  }

  Widget memberApprovalTag() {
    return const Center(
      child: Text("Member Approval Details", style: TextStyle(fontSize: 12)),
    );
  }

  Widget loanApplicantCard() {
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
                          label: Text('Ref NO', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Repay Date',
                              style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Name', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label: Text('Email', style: TextStyle(fontSize: 8))),
                      DataColumn(
                          label:
                              Text('Phone No', style: TextStyle(fontSize: 8))),
                    ],
                    rows: const [],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget approvalPercentageCard() {
    return Card(
      color: Colors.white,
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 15,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.16,
            child: Center(
              child: Column(
                children: const <Widget>[
                  Text(
                    "Approval Percentage   75%",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
            icon: const Icon(Icons.more_vert_sharp, color: Colors.black),
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
                      Row(children: <Widget>[loanApplicantCard()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 5,
            top: 300,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[approvalPercentageCard()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 5,
            top: 170,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[membersApprovalCard()]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 17,
            top: 15,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[applicantsTag()],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 17,
            top: 155,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        memberApprovalTag(),
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
