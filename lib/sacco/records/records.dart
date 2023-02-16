import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/deposit/feed/deposit_feed.dart';
import 'package:saccofy/sacco/loan/feed/loan_disbursed_feed.dart';
import 'package:saccofy/sacco/loan/feed/loan_feed.dart';
import 'package:saccofy/sacco/loan/feed/loan_requested_feed.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';

class SaccoRecords extends StatefulWidget {
  const SaccoRecords({super.key});

  @override
  SaccoRecordsState createState() => SaccoRecordsState();
}

class SaccoRecordsState extends State<SaccoRecords> {
  void selectedItem(BuildContext context, item) {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    switch (item) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SaccoLoanRequestFeed()));
        break;
    }
  }

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
          // IconButton(
          //   icon: const Icon(
          //     Icons.search,
          //     size: 20,
          //   ),
          //   onPressed: () {},
          // ),
          Theme(
            data: Theme.of(context).copyWith(
                textTheme: const TextTheme().apply(bodyColor: Colors.black),
                dividerColor: const Color.fromARGB(255, 221, 219, 219),
                iconTheme: const IconThemeData(color: Colors.white)),
            child: Container(
              height: 5,
              child: PopupMenuButton<int>(
                color: const Color(0xff1c3751),
                constraints: const BoxConstraints(
                  minHeight: 10,
                  maxHeight: 250,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    height: 25.0,
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.details,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Loans",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                onSelected: (item) => selectedItem(context, item),
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            // SizedBox(
            //   height: 20,
            // ),
            Row(
              children: [
                deposits(),
                const SizedBox(
                  width: 10,
                ),
                loansDisbursed(),
                const SizedBox(
                  width: 10,
                ),
                loansRequested()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget deposits() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 1, 18, 32),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) {
              //       return const LoanScreenSection();
              //     },
              //   ),
              // );
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Deposits",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/file.png',
                  width: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget loansDisbursed() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 1, 18, 32),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LoanDisbursedFeed();
                  },
                ),
              );
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Loans Disbursed",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/file2.png',
                  width: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget loansRequested() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 1, 18, 32),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const SaccoLoanRequestFeed();
                  },
                ),
              );
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Loans Requested",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/file2.png',
                  width: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
