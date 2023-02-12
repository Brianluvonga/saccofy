// view of loan application request that other members can see and approve

import 'package:flutter/material.dart';

class LoanRequestView extends StatefulWidget {
  const LoanRequestView({super.key});

  @override
  State<LoanRequestView> createState() => _LoanRequestViewState();
}

class _LoanRequestViewState extends State<LoanRequestView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget fetchLoanRequestList() {
    return Card(
      color: Colors.white,
      child: Container(
        height: 100,
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
