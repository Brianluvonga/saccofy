import 'package:flutter/material.dart';

class MemberRejectedLoans extends StatefulWidget {
  const MemberRejectedLoans({super.key});

  @override
  State<MemberRejectedLoans> createState() => _MemberRejectedLoansState();
}

class _MemberRejectedLoansState extends State<MemberRejectedLoans> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: noResultsFound(),
    );
  }

  Widget noResultsFound() {
    return const Center(
      child: Text('No Loans Rejected Found'),
    );
  }
}
