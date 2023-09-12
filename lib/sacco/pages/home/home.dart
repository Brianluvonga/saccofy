import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/deposit/feed/deposit_feed.dart';
import 'package:saccofy/sacco/deposit/functions/functions.dart';
import 'package:saccofy/sacco/deposit/view_deposits.dart';
import 'package:saccofy/sacco/details/member/deposits/deposits.dart';
import 'package:saccofy/sacco/details/member/loansapplied/loans_approved.dart';
import 'package:saccofy/sacco/details/member/loansapproved/loans_rejected.dart';
import 'package:saccofy/sacco/details/member/loansrequested/loans_requested.dart';
import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';
import 'package:saccofy/sacco/details/member/view_member_details.dart';
import 'package:saccofy/sacco/details/sacco_infomation.dart';
import 'package:saccofy/sacco/loan/application/loan_application.dart';
import 'package:saccofy/sacco/loan/feed/loan_details.dart';
import 'package:saccofy/sacco/loan/feed/loan_feed.dart';
import 'package:saccofy/sacco/loan/feed/loan_requested_feed.dart';
import 'package:saccofy/sacco/loan/functions/loan_functions.dart';
import 'package:saccofy/sacco/loan/notifier/loan_request_notifier.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';
import 'package:saccofy/sacco/pages/member/add/add_member.dart';
import 'package:saccofy/sacco/records/loan/loan_records.dart';
import 'package:saccofy/sacco/records/records.dart';
import 'package:saccofy/user/auth/firebase/api.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/records/loans/requested_loan_feed.dart';

class SaccoHomePage extends StatefulWidget {
  const SaccoHomePage({super.key});

  @override
  State<SaccoHomePage> createState() => _SaccoHomePageState();
}

class _SaccoHomePageState extends State<SaccoHomePage> {
  NumbersService totalDeposit = NumbersService();
  int? count;

  @override
  void initState() {
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    getSaccoMembers(
        memberNotifier, saccoNotifier.currentSacco.saccoId.toString());

    super.initState();
  }

  // Initiate what is to be seen
  ActionType action = ActionType.contributions;

  void selectedItem(BuildContext context, item) {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SaccoDetails()));
        break;
      case 1:
        saccoNotifier.currentSacco = saccoNotifier.saccoList[0];

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SaccoRecords(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoanApplicationForm(),
          ),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddMemberToSacco(),
          ),
        );
        break;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c3751),
        elevation: 0,
        title: Text(
          saccoNotifier.currentSacco.saccoName.toString(),
          style: const TextStyle(fontSize: 14),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: const Icon(
          //     Icons.search,
          //     size: 20,
          //   ),
          //   onPressed: () {
          //     // handle the press
          //   },
          // ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(memberNotifier.currentMember.id)
                .collection('notifications')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Icon(
                  Icons.notifications,
                  size: 30,
                );
              }
              int count = snapshot.data!.docs.length;
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      size: 20,
                    ),
                    onPressed: () {
                      // handle the press
                    },
                  ),
                  count != ''
                      ? Positioned(
                          right: 10,
                          top: 10,
                          child: Text(
                            count.toString(),
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(),
                ],
              );
            },
          ),
          Theme(
            data: Theme.of(context).copyWith(
                textTheme: const TextTheme().apply(bodyColor: Colors.black),
                dividerColor: const Color.fromARGB(255, 221, 219, 219),
                iconTheme: const IconThemeData(color: Colors.white)),
            child: Container(
              height: 5,
              child: PopupMenuButton<int>(
                color: const Color(0xff1c3751),
                constraints: const BoxConstraints(
                  minHeight: 10,
                  maxHeight: 250,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    height: 25.0,
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.details,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<int>(
                    height: 25.0,
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.receipt_sharp,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Records",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<int>(
                    height: 25.0,
                    value: 2,
                    child: Row(
                      children: [
                        Image.asset(
                          'images/file2.png',
                          width: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text(
                          "Apply Loan",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<int>(
                    height: 25.0,
                    value: 3,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.group_add_outlined,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text("Add Member",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ],
                onSelected: (item) => selectedItem(context, item),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Wrap(
          children: [
            totalContributionsCard(),
            headersTitle('Members'),
            FutureBuilder(
              future: getSaccoMembers(memberNotifier,
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
            recentActivityHeader(),
            two(),
          ],
        ),
      ),
    );
  }

  Widget membersCount() {
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            memberNotifier.memberList.length.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget totalContributionsCard() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 140,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 1, 18, 32),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
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
                "Current Deposits",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: 'times',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<double>(
                future: totalDeposit.getSaccoTotalDeposit(
                    saccoNotifier.currentSacco.saccoId.toString()),
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
        Positioned(
          top: 5,
          // left: 20,
          right: 15,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 110,
          left: 20,
          right: 25,
          child: Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all()),
            child: IconButton(
              iconSize: 20,
              onPressed: () {
                print('Tapped');
              },
              icon: const Icon(
                Icons.add,
                size: 25,
              ),
              // color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget actionTitles() {
    return Row(
      children: const [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Deposits',
            style: TextStyle(fontSize: 10, fontFamily: 'times'),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Loans',
            style: TextStyle(fontSize: 10, fontFamily: 'times'),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  Widget headersTitle(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color.fromARGB(255, 54, 54, 54),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget recentActivityHeader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: const [
            Text(
              'Recent Activities',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 54, 54, 54),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  List<String> loans = [
    'Deposits',
    'Loan Requests',
    'Loans Disbursed',
    'Loans Paid'
  ];
  int selectedMenuIndex = 0;

  Widget _getBody() {
    switch (selectedMenuIndex) {
      case 0:
        return const SaccoDepositFeed();
      case 1:
        return const Text('Loan Requests');
      case 2:
        return const MemberRejectedLoans();
      default:
        return const Text('Loan Paid');
    }
  }

  bool isSelected = false;

  Widget two() {
    return Wrap(
      direction: Axis.vertical,
      spacing: 20,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(loans.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedMenuIndex = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selectedMenuIndex == index
                        ? const Color(0xff1c3751)
                        : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    border: Border.all(color: const Color(0xff1c3751)),
                  ),
                  child: Text(
                    loans[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: selectedMenuIndex == index
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        _getBody(),
      ],
    );
  }

  Widget getButtonUI(ActionType actionTypeData, bool isSelected) {
    String txt = '';
    if (ActionType.contributions == actionTypeData) {
      txt = 'Deposits';
    } else if (ActionType.loanRequests == actionTypeData) {
      txt = 'Requests';
    } else if (ActionType.loansDisbursed == actionTypeData) {
      txt = 'Disbursed';
    } else if (ActionType.paid == actionTypeData) {
      txt = 'Paid';
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? const Color(0xff1c3751) : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: const Color(0xff1c3751))),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                action = actionTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                    letterSpacing: 0.27,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// members widget section

  Widget memberFeedCard() {
    MemberNotifier memberNotifier =
        Provider.of<MemberNotifier>(context, listen: false);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          memberNotifier.memberList.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  memberNotifier.currentMember =
                      memberNotifier.memberList[index];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const MemberDetails();
                      },
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: memberNotifier.memberList[index].profilePic
                              .toString(),
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xff1c3751),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      memberNotifier.memberList[index].firstname.toString(),
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

// Display below recent activites for navigation
enum ActionType {
  contributions,
  loanRequests,
  loansDisbursed,
  paid,
}
