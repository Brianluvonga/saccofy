import 'package:flutter/material.dart';

class ViewSaccoDeposits extends StatefulWidget {
  const ViewSaccoDeposits({super.key});

  @override
  State<ViewSaccoDeposits> createState() => _ViewSaccoDepositsState();
}

class _ViewSaccoDepositsState extends State<ViewSaccoDeposits> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xff1c3751),
      child: Scaffold(
        backgroundColor: const Color(0xff1c3751),
        appBar: AppBar(
          backgroundColor: const Color(0xff1c3751),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Sacco Deposits',
            style: TextStyle(fontFamily: 'times', fontSize: 13),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
