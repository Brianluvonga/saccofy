import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/deposit/functions/functions.dart';
import 'package:saccofy/sacco/details/member/deposits/deposits.dart';
import 'package:saccofy/sacco/details/member/loansapplied/loans_approved.dart';
import 'package:saccofy/sacco/details/member/loansapproved/loans_rejected.dart';
import 'package:saccofy/sacco/details/member/loansrequested/loans_requested.dart';
import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';

class MemberDetails extends StatefulWidget {
  const MemberDetails({Key? key}) : super(key: key);

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  NumbersService totalDeposit = NumbersService();

  @override
  Widget build(BuildContext context) {
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c3751),
        title: const Text(
          "Member Info",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        elevation: 5,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () {
              // handle the press
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 15,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          // Container(
          //   decoration: const BoxDecoration(
          //     color: Color.fromARGB(255, 250, 227, 235),
          //   ),
          // ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: <Widget>[
                          Positioned(
                            top: 20,
                            left: 10,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FullScreenImage(
                                      imageUrl: memberNotifier
                                          .currentMember.profilePic
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 65,
                                height: 65,
                                child: ClipOval(
                                  child: Image.network(
                                    memberNotifier.currentMember.profilePic
                                        .toString(),
                                    fit: BoxFit.cover,
                                    scale: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 170,
                            child: totalContributionsCard(),
                          ),
                          SizedBox(
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 55.0, bottom: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 70.0),
                                          personalmemberContributionCard(),
                                          const Divider(
                                            color: Colors.white,
                                            height: 40.0,
                                            thickness: .5,
                                            indent: 32.0,
                                            endIndent: 32.0,
                                          ),
                                          // const SizedBox(height: 10.0),
                                          // progressScoreTitle(),
                                          const SizedBox(height: 10.0),
                                          two(),
                                          SizedBox(
                                            height: 50,
                                            child: GridView.count(
                                              primary: false,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24.0,
                                                      vertical: 15.0),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 3,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
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

  Widget personalmemberContributionCard() {
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);

    return Card(
      color: Colors.white,
      elevation: 5.0,
      shadowColor: Colors.white,
      child: Container(
        height: 120,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.16,
          child: Center(
            child: Column(
              children: <Widget>[
                DataTable(
                  columnSpacing: 35,
                  columns: const [
                    DataColumn(
                        label: Text('Name', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Email', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Gender', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Phone', style: TextStyle(fontSize: 8))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        Text(
                            '${memberNotifier.currentMember.firstname} ${memberNotifier.currentMember.lastname}',
                            style: const TextStyle(fontSize: 8)),
                      ),
                      DataCell(
                        Text(memberNotifier.currentMember.email.toString(),
                            style: const TextStyle(fontSize: 8)),
                      ),
                      DataCell(
                        Text(memberNotifier.currentMember.gender.toString(),
                            style: const TextStyle(fontSize: 8)),
                      ),
                      DataCell(
                        Text(
                            memberNotifier.currentMember.phonenumber.toString(),
                            style: const TextStyle(fontSize: 8)),
                      ),
                    ])
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget progressScoreTitle() {
    return const Text(
      'Progress Score',
      textAlign: TextAlign.left,
    );
  }

  int selectedMenuIndex = 0;

  List<String> loans = [
    'Deposits',
    'Loans Approved',
    'Loans Rejected',
    'Loans Requested'
  ];
  Widget _getBody() {
    switch (selectedMenuIndex) {
      case 0:
        return const MemberDeposits();
      case 1:
        return const LoansMemberApproved();
      case 2:
        return const MemberRejectedLoans();
      default:
        return const MemberLoanRequests();
    }
  }

  Widget two() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 48.0,
            color: const Color.fromARGB(255, 94, 130, 163),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(loans.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMenuIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      loans[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: selectedMenuIndex == index
                            ? const Color(0xff1c3751)
                            : Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: _getBody(),
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
