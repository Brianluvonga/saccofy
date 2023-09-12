import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saccofy/sacco/deposit/functions/functions.dart';

class MemberDeposits extends StatefulWidget {
  const MemberDeposits({super.key});

  @override
  State<MemberDeposits> createState() => _MemberDepositsState();
}

class _MemberDepositsState extends State<MemberDeposits> {
  NumbersService totalDeposit = NumbersService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Center(child: totalContributionsCard()),
      ],
    );
  }

  Widget totalContributionsCard() {
    var currentMember = FirebaseAuth.instance.currentUser;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 94, 130, 163),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Total Sacco Deposits",
                style: TextStyle(
                    color: Colors.white, fontSize: 12, fontFamily: 'times'),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<double>(
                future: totalDeposit.getUserTotalDeposit(currentMember!.uid),
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "${snapshot.data}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    );
                  } else if (snapshot.data == null) {
                    return const Text("0",
                        style: TextStyle(color: Colors.white));
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
