import 'package:flutter/material.dart';

class LoanRecords extends StatefulWidget {
  const LoanRecords({Key? key}) : super(key: key);

  @override
  State<LoanRecords> createState() => _LoanRecordsState();
}

class _LoanRecordsState extends State<LoanRecords> {
  LoanBar loanType = LoanBar.all;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Loan Records',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        leading: const Icon(
          Icons.arrow_circle_left_outlined,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.more_vert_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                top: 20.0,
                width: size.width,
                child: getLoanBarUI(),
              ),
              Positioned(
                top: 120.0,
                left: 18,
                child: Center(
                  child: memberLoanCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // loan tap buttons

  Widget getButtonUI(LoanBar loanBarData, bool isSelected) {
    String txt = '';
    if (LoanBar.all == loanBarData) {
      txt = 'All';
    } else if (LoanBar.pending == loanBarData) {
      txt = 'Pending';
    } else if (LoanBar.approved == loanBarData) {
      txt = 'Approved';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? const Color(0xff1c3751) : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: const Color(0xff1c3751))),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                loanType = loanBarData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 16, right: 16),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    // fontWeight: FontWeight.w30,
                    fontSize: 10,
                    letterSpacing: 0.27,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLoanBarUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'View',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: 0.30,
              color: Color(0xff1c3751),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(LoanBar.all, loanType == LoanBar.all),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(LoanBar.pending, loanType == LoanBar.pending),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(LoanBar.approved, loanType == LoanBar.approved),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget memberLoanCard() {
    return Card(
      color: Color.fromARGB(255, 236, 234, 234),
      elevation: 10.0,
      shadowColor: Colors.white,
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        // width: 350,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(15.0),
        // ),
        child: Container(
          alignment: Alignment.center,
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height * 0.16,
          child: Center(
            child: Column(
              children: <Widget>[
                DataTable(
                  columnSpacing: 30,
                  columns: const [
                    DataColumn(
                        label: Text('Member',
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('loanAmount',
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('To Pay',
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Ref No',
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Repayment Date',
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w600))),
                    DataColumn(
                        label: Text('Status',
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w600))),
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

// for easy user navigation
enum LoanBar {
  all,
  pending,
  approved,
}
