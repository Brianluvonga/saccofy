import 'package:flutter/material.dart';

class LoansMemberApproved extends StatefulWidget {
  const LoansMemberApproved({super.key});

  @override
  State<LoansMemberApproved> createState() => _LoansMemberApprovedState();
}

class _LoansMemberApprovedState extends State<LoansMemberApproved> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: noResultsFound(),
    );
  }

  Widget noResultsFound() {
    return const Center(
      child: Text('No Loans Approved Found'),
    );
  }
}
