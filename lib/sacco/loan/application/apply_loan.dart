import 'package:flutter/material.dart';

class ApplyLoan extends StatefulWidget {
  const ApplyLoan({super.key});

  @override
  State<ApplyLoan> createState() => _ApplyLoanState();
}

class _ApplyLoanState extends State<ApplyLoan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Loan Application",
          style: TextStyle(fontFamily: 'times', fontSize: 12),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1c3751),
        // actions: [],
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios_new,
        //     color: Colors.white,
        //     size: 15,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
    );
  }
}
