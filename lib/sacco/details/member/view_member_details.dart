import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/deposit/functions/functions.dart';
import 'package:saccofy/sacco/details/member/deposits/deposits.dart';
import 'package:saccofy/sacco/details/member/loansrequested/loans_requested.dart';

import 'package:saccofy/sacco/details/member/notifier/member_notifier.dart';

class MemberDetails extends StatefulWidget {
  const MemberDetails({Key? key}) : super(key: key);

  @override
  State<MemberDetails> createState() => MemberDetailsState();
}

class MemberDetailsState extends State<MemberDetails> {
  NumbersService totalDeposit = NumbersService();
  int selectedMenuIndex = 0;

  List<String> loans = ['Deposits', 'Requested', 'Approved', 'Awarded'];

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Color.fromARGB(255, 36, 70, 102),
            height: 50.0,
            child: 
            Row(
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
                        fontSize: 14.0,
                        color: selectedMenuIndex == index
                            ? Color.fromARGB(255, 247, 132, 170)
                            : Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullScreenImage(
                    imageUrl:
                        memberNotifier.currentMember.profilePic.toString(),
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  memberNotifier.currentMember.profilePic.toString()),
            ),
          ),
          SizedBox(
            width: 5,
          ),
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
      body: getBody(),
    );
  }

  Widget getBody() {
    switch (selectedMenuIndex) {
      case 0:
        return const MemberDeposits();

      case 1:
        return const MemberLoanRequests();
      case 2:
        return const Center(child: Text('Loans Approved'));
      default:
        return const Center(child: Text('Loans Awarded'));
    }
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          personalmemberContributionCard(context)
        ],
      ),
    );
  }

  Widget personalmemberContributionCard(context) {
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
                        label:
                            Text('Full Name', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Email', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Gender', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Phone', style: TextStyle(fontSize: 10))),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                              '${memberNotifier.currentMember.firstname} ${memberNotifier.currentMember.lastname}',
                              style: const TextStyle(fontSize: 9)),
                        ),
                        DataCell(
                          Text(memberNotifier.currentMember.email.toString(),
                              style: const TextStyle(fontSize: 9)),
                        ),
                        DataCell(
                          Text(memberNotifier.currentMember.gender.toString(),
                              style: const TextStyle(fontSize: 9)),
                        ),
                        DataCell(
                          Text(
                              memberNotifier.currentMember.phonenumber
                                  .toString(),
                              style: const TextStyle(fontSize: 9)),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
