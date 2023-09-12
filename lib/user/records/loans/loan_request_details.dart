import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/loan/approval/members/view_members_approved.dart';
import 'package:saccofy/sacco/loan/functions/loan_functions.dart';
import 'package:saccofy/sacco/loan/notifier/loan_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/loan_request_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/member_approval_notifier.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';

class IndividualLoanDetails extends StatefulWidget {
  const IndividualLoanDetails({super.key});

  @override
  State<IndividualLoanDetails> createState() => _IndividualLoanDetailsState();
}

class _IndividualLoanDetailsState extends State<IndividualLoanDetails> {
  LoanService loanRequest = LoanService();
  @override
  Widget build(BuildContext context) {
    LoanRequestNotifier loanNotifier =
        Provider.of<LoanRequestNotifier>(context);
    SaccoNotifier saccoNotifier = Provider.of<SaccoNotifier>(context);
    var currentMember = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Loan Request Details',
          style: TextStyle(fontFamily: 'times', fontSize: 12),
        ),
        backgroundColor: const Color(0xff1c3751),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.people),
                onPressed: () {
                  loanNotifier.currentLoan = loanNotifier.loanRequestlist[0];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const MemberLoanApprovalFeed();
                      },
                    ),
                  );
                },
              ),
              Positioned(
                top: 0,
                right: 5,
                child: FutureBuilder<int>(
                  future: loanRequest.numberOfApprovals(
                      saccoNotifier.currentSacco.saccoId.toString(),
                      loanNotifier.currentLoan.id.toString()),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "${snapshot.data}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      );
                    } else if (snapshot.data == null) {
                      return Container();
                    } else {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      );
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              DataTable(
                columnSpacing: 15,
                columns: const [
                  DataColumn(
                    label: Text(
                      'amount',
                      style: TextStyle(
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'interest',
                      style: TextStyle(
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      ' applied',
                      style: TextStyle(
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'repayDate',
                      style: TextStyle(
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'purpose',
                      style: TextStyle(
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'status',
                      style: TextStyle(
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        Text(
                          loanNotifier.currentLoan.loanAmount.toString(),
                          style: const TextStyle(
                              fontFamily: 'times', fontSize: 10),
                        ),
                      ),
                      DataCell(
                        Text(
                          loanNotifier.currentLoan.interestRate.toString(),
                          style: const TextStyle(
                              fontFamily: 'times', fontSize: 10),
                        ),
                      ),
                      DataCell(
                        Text(
                          loanNotifier.currentLoan.dateOfRequest.toString(),
                          style: const TextStyle(
                              fontFamily: 'times', fontSize: 10),
                        ),
                      ),
                      DataCell(
                        Text(
                          loanNotifier.currentLoan.dateOfRepayment.toString(),
                          style: const TextStyle(
                              fontFamily: 'times', fontSize: 10),
                        ),
                      ),
                      DataCell(
                        Text(
                          loanNotifier.currentLoan.loanPurpose.toString(),
                          style: const TextStyle(
                              fontFamily: 'times', fontSize: 10),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
                              border:
                                  Border.all(color: const Color(0xff1c3751))),
                          child: Text(
                            loanNotifier.currentLoan.status.toString(),
                            style: const TextStyle(
                              fontFamily: 'times',
                              fontSize: 10,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  getMemberApproved() {}
}
