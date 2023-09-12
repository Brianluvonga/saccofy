import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';
import 'package:saccofy/sacco/details/member/view_member_details.dart';

import 'package:saccofy/sacco/loan/functions/loan_functions.dart';
import 'package:saccofy/sacco/loan/notifier/loan_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/loan_request_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/member_approval_notifier.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';

class MemberLoanApprovalFeed extends StatefulWidget {
  const MemberLoanApprovalFeed({Key? key, this.callBack}) : super(key: key);
  final Function()? callBack;

  @override
  // ignore: library_private_types_in_public_api
  _MemberLoanApprovalFeedState createState() => _MemberLoanApprovalFeedState();
}

class _MemberLoanApprovalFeedState extends State<MemberLoanApprovalFeed> {
  LoanService loanService = LoanService();
  @override
  void initState() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    LoanRequestNotifier loanNotifier =
        Provider.of<LoanRequestNotifier>(context, listen: false);
    MemberApprovalNotifier memberNotifier =
        Provider.of<MemberApprovalNotifier>(context, listen: false);
    loanService.getMembersWhoApprovedLoan(
        memberNotifier,
        loanNotifier.currentLoan.id.toString(),
        saccoNotifier.currentSacco.saccoId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    LoanRequestNotifier loanNotifier =
        Provider.of<LoanRequestNotifier>(context, listen: false);
    MemberApprovalNotifier memberNotifier =
        Provider.of<MemberApprovalNotifier>(context, listen: false);

    Future refreshList() async {
      loanService.getMembersWhoApprovedLoan(
          memberNotifier,
          loanNotifier.currentLoan.id.toString(),
          saccoNotifier.currentSacco.saccoId.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Members Approved',
          style: TextStyle(fontFamily: 'times', fontSize: 12),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff1c3751),
        actions: const [],
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: loanService.getMembersWhoApprovedLoan(
                memberNotifier,
                loanNotifier.currentLoan.id.toString(),
                saccoNotifier.currentSacco.saccoId.toString()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xff1c3751),
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return memberFeedCard();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget memberFeedCard() {
    MemberApprovalNotifier memberNotifier =
        Provider.of<MemberApprovalNotifier>(context, listen: false);

    return SingleChildScrollView(
      // scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          memberNotifier.memberLoanApprovalList.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipOval(
                        child: Image.network(
                          memberNotifier
                              .memberLoanApprovalList[index].profilePic
                              .toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      memberNotifier.memberLoanApprovalList[index].firstname
                          .toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
