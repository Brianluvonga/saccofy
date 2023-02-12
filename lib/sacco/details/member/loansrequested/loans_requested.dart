import 'package:flutter/material.dart';

class MemberLoanRequests extends StatefulWidget {
  const MemberLoanRequests({super.key});

  @override
  State<MemberLoanRequests> createState() => _MemberLoanRequestsState();
}

class _MemberLoanRequestsState extends State<MemberLoanRequests> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: noLoansRequestedFound(),
    );
  }

  Widget noLoansRequestedFound() {
    return const Center(
      child: Text('No Loan Requests Found'),
    );
  }
}
