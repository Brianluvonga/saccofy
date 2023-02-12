import 'package:flutter/material.dart';
import 'package:saccofy/sacco/deposit/feed/deposit_feed.dart';
import 'package:saccofy/sacco/loan/feed/loan_feed.dart';

class SaccoRecords extends StatefulWidget {
  const SaccoRecords({super.key});

  @override
  SaccoRecordsState createState() => SaccoRecordsState();
}

class SaccoRecordsState extends State<SaccoRecords> {
  int selectedMenuIndex = 0;

  List<String> loans = ['Deposits', 'Loans'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c3751),
        title: const Text(
          'Records',
          style: TextStyle(fontSize: 14, fontFamily: 'times'),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 20,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Color.fromARGB(255, 31, 62, 90),
            height: 48.0,
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
                            ? Colors.grey
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
          child: SaccoDepositFeed(),
        );

      default:
        return const Center(
          child: SaccoLoanFeed(),
        );
    }
  }
}
