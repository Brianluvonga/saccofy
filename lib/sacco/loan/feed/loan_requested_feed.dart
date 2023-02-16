import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/loan/feed/loan_details.dart';
import 'package:saccofy/sacco/loan/functions/loan_functions.dart';
import 'package:saccofy/sacco/loan/models/loan_request_model.dart';
import 'package:saccofy/sacco/loan/notifier/loan_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/loan_request_notifier.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';

class SaccoLoanRequestFeed extends StatefulWidget {
  const SaccoLoanRequestFeed({super.key});

  @override
  State<SaccoLoanRequestFeed> createState() => _SaccoLoanRequestFeedState();
}

class _SaccoLoanRequestFeedState extends State<SaccoLoanRequestFeed> {
  LoanService loanService = LoanService();

  @override
  void initState() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    LoanRequestNotifier loanRequestNotifier =
        Provider.of<LoanRequestNotifier>(context, listen: false);
    UserModelNotifier userNotifier =
        Provider.of<UserModelNotifier>(context, listen: false);
    loanService.fetchLoanRequests(
        userNotifier, loanRequestNotifier, saccoNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    LoanRequestNotifier loanRequestNotifier =
        Provider.of<LoanRequestNotifier>(context, listen: false);
    UserModelNotifier userNotifier =
        Provider.of<UserModelNotifier>(context, listen: false);

    Future<void> refreshList() async {
      loanService.fetchLoanRequests(
          userNotifier, loanRequestNotifier, saccoNotifier);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Loan Requests',
          style: TextStyle(fontFamily: 'times', fontSize: 12),
        ),
        backgroundColor: const Color(0xff1c3751),
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: loanService.fetchLoanRequests(
                userNotifier, loanRequestNotifier, saccoNotifier),
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
          subtitle: Text(loanRequestNotifier.loanRequestlist[index].loanPurpose!
              .toString()
              .trim()),
          leading: Text(
              loanRequestNotifier.loanRequestlist[index].memberId.toString()),
          trailing:
              Text(loanRequestNotifier.loanRequestlist[index].dateOfRepayment!),
          onTap: () {
            loanRequestNotifier.currentLoan =
                loanRequestNotifier.loanRequestlist[index];
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const LoanDetails();
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
