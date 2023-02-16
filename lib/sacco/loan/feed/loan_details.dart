import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/loan/notifier/loan_notifier.dart';
import 'package:saccofy/sacco/loan/notifier/loan_request_notifier.dart';

class LoanDetails extends StatefulWidget {
  const LoanDetails({super.key});

  @override
  State<LoanDetails> createState() => _LoanDetailsState();
}

class _LoanDetailsState extends State<LoanDetails> {
  @override
  Widget build(BuildContext context) {
    LoanRequestNotifier loanNotifier =
        Provider.of<LoanRequestNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Loan Details',
          style: TextStyle(fontFamily: 'times', fontSize: 12),
        ),
        backgroundColor: const Color(0xff1c3751),
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () {},
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
                      'name',
                      style: TextStyle(
                          fontFamily: 'times',
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
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
                          loanNotifier.currentLoan.memberId.toString(),
                          style: const TextStyle(
                              fontFamily: 'times', fontSize: 10),
                        ),
                      ),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.green,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                      minWidth: 100,
                      onPressed: () {},
                      child: const Text(
                        'approve',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.red,
                    child: MaterialButton(
                      // padding:
                      //     const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                      minWidth: 100,
                      onPressed: () {},
                      child: const Text(
                        'reject',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
