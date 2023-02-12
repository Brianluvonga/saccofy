import 'package:flutter/material.dart';

class MemberDeposits extends StatefulWidget {
  const MemberDeposits({super.key});

  @override
  State<MemberDeposits> createState() => _MemberDepositsState();
}

class _MemberDepositsState extends State<MemberDeposits> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: noResultsFound(),
    );
  }

  Widget noResultsFound() {
    return const Center(
      child: Text('No Deposits Found'),
    );
  }
}
