import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/loan/feed/loan_details.dart';
import 'package:saccofy/sacco/loan/functions/loan_functions.dart';

import 'package:saccofy/sacco/loan/notifier/loan_request_notifier.dart';

import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/records/loans/loan_request_details.dart';

class IndividualLoanRequestFeed extends StatefulWidget {
  const IndividualLoanRequestFeed({super.key});

  @override
  State<IndividualLoanRequestFeed> createState() =>
      _IndividualLoanRequestFeedState();
}

class _IndividualLoanRequestFeedState extends State<IndividualLoanRequestFeed> {
  LoanService loanService = LoanService();

  @override
  void initState() {
    LoanRequestNotifier loanRequestNotifier =
        Provider.of<LoanRequestNotifier>(context, listen: false);
    UserModelNotifier userNotifier =
        Provider.of<UserModelNotifier>(context, listen: false);
    var currentMember = FirebaseAuth.instance.currentUser;

    loanService.fetchIndividualLoanRequests(
        currentMember!.uid, loanRequestNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoanRequestNotifier loanRequestNotifier =
        Provider.of<LoanRequestNotifier>(context, listen: false);
    UserModelNotifier userNotifier =
        Provider.of<UserModelNotifier>(context, listen: false);

    var currentMember = FirebaseAuth.instance.currentUser;

    Future<void> refreshList() async {
      loanService.fetchIndividualLoanRequests(
          currentMember!.uid, loanRequestNotifier);
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: loanService.fetchIndividualLoanRequests(
                currentMember!.uid, loanRequestNotifier),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xff1c3751),
                  ),
                );
              }
              // check if snapshot.data is null
              if (snapshot.data.toString().isNotEmpty) {
                return Center(
                  child: loanGrid(),
                );
              } else {
                return const Center(
                  child: Text('No Loan Records At The Moment'),
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget loanGrid() {
    LoanRequestNotifier loanRequestNotifier =
        Provider.of<LoanRequestNotifier>(context, listen: false);

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            loanRequestNotifier.loanRequestlist[index].loanAmount.toString(),
          ),
          subtitle: Text(loanRequestNotifier
              .loanRequestlist[index].dateOfRepayment!
              .toString()
              .trim()),
          leading: Text(loanRequestNotifier.loanRequestlist[index].loanPurpose
              .toString()),
          trailing: Text(loanRequestNotifier.loanRequestlist[index].status!),
          onTap: () {
            loanRequestNotifier.currentLoan =
                loanRequestNotifier.loanRequestlist[index];
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const IndividualLoanDetails();
                },
              ),
            );
          },
        );
      },
      itemCount: loanRequestNotifier.loanRequestlist.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.black,
        );
      },
    );
  }
}
