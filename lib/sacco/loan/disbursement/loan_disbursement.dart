import 'package:flutter/material.dart';

class DisburseFundsToMember extends StatefulWidget {
  const DisburseFundsToMember({Key? key}) : super(key: key);

  @override
  State<DisburseFundsToMember> createState() => _DisburseFundsToMemberState();
}

class _DisburseFundsToMemberState extends State<DisburseFundsToMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(),
      ),
    );
  }

  Widget disburseFunds() {
    return Card(
      elevation: 10,
      child: Expanded(
        child: Container(),
      ),
    );
  }
}
