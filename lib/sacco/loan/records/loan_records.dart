import 'package:flutter/material.dart';

class LoanRecords extends StatefulWidget {
  const LoanRecords({Key? key}) : super(key: key);

  @override
  State<LoanRecords> createState() => _LoanRecordsState();
}

class _LoanRecordsState extends State<LoanRecords> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 2,
        title: const Text('Loan Records'),
        leading: const Icon(
          Icons.arrow_circle_left_outlined,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(),
      ),
    );
  }

  Widget memberLoanCard() {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      shadowColor: Colors.white,
      child: Container(
        height: 100,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.16,
          child: Center(
            child: Column(
              children: <Widget>[
                DataTable(
                  columnSpacing: 35,
                  columns: const [
                    DataColumn(
                        label: Text('Name', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label:
                            Text('Loan Amount', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Interest', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Amount To Pay',
                            style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Ref No', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Repayment Date',
                            style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Status', style: TextStyle(fontSize: 8))),
                  ],
                  rows: const [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
