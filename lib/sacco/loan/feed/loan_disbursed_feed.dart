import 'package:flutter/material.dart';

class LoanDisbursedFeed extends StatefulWidget {
  const LoanDisbursedFeed({super.key});

  @override
  State<LoanDisbursedFeed> createState() => _LoanDisbursedFeedState();
}

class _LoanDisbursedFeedState extends State<LoanDisbursedFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c3751),
        centerTitle: true,
        title: const Text(
          'Loans Disbursed',
          style: TextStyle(
            fontFamily: 'times',
            fontSize: 12,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 20,
            ),
            onPressed: () {
              // handle the press
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert_outlined,
              size: 20,
            ),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
