import 'package:flutter/material.dart';
import 'package:saccofy/user/records/loans/requested_loan_feed.dart';

class LoanScreenSection extends StatefulWidget {
  const LoanScreenSection({super.key});

  @override
  LoanScreenSectionState createState() => LoanScreenSectionState();
}

class LoanScreenSectionState extends State<LoanScreenSection> {
  int selectedMenuIndex = 0;

  List<String> loans = ['Requested', 'Approved', 'Awarded'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c3751),
        title: const Text(
          'Loans Section',
          style: TextStyle(fontSize: 14, fontFamily: 'times'),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Color.fromARGB(255, 36, 70, 102),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(loans.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMenuIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      loans[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: selectedMenuIndex == index
                            ? Color.fromARGB(255, 247, 132, 170)
                            : Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    switch (selectedMenuIndex) {
      case 0:
        return const Center(
          child: IndividualLoanRequestFeed(),
        );
      case 1:
        return const Center(child: Text('Loans Approved'));
      case 2:
        return const Center(child: Text('Loans Applied'));
      default:
        return const Center(child: Text('Loans Requested'));
    }
  }
}
