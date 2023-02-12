import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:saccofy/home/sampleforgot.dart';

class IndividualMemberContributionPage extends StatefulWidget {
  const IndividualMemberContributionPage({super.key});

  @override
  State<IndividualMemberContributionPage> createState() =>
      _IndividualMemberContributionPageState();
}

class _IndividualMemberContributionPageState
    extends State<IndividualMemberContributionPage> {
  ActionType action = ActionType.all;

  String? username = "Brian Luvonga";
  String? email = "brnluvonga@gmail.com";
  String? phoneNumber = "0791447754";
  String? gender = "male";
  String? dateJoined = "01/102/2023";
  String? about =
      "This will allow the text to take up the available space and adjust its font size based on the size of the text.";

  // Initiate what is to be seen
  //
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c3751),
        elevation: 0,
        title: const Text(
          "Member Sacco Info",
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_sharp),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          height: size.height,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.20,
                color: const Color(0xff1c3751),
              ),
              Positioned(
                top: 20.0,
                left: -100,
                width: size.width,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      saccoProfileLogo(),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 20.0,
                left: 150,
                width: size.width,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      memberDetails(
                        username.toString(),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      memberDetails(
                        email.toString(),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      memberDetails(
                        phoneNumber.toString(),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      memberDetails(
                        gender.toString(),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 100.0,
                left: 10,
                width: size.width,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      memberDetails(
                        about.toString(),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 130.0,
                left: 270,
                width: size.width,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      memberDetails(
                        'date joined : $dateJoined',
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 150.0,
                left: -30,
                width: size.width,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      recentActivityHeader(),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 200.0,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: <Widget>[
                      getButtonUI(ActionType.all, action == ActionType.all),
                      const SizedBox(
                        width: 16,
                      ),
                      getButtonUI(ActionType.contributions,
                          action == ActionType.contributions),
                      const SizedBox(
                        width: 16,
                      ),
                      getButtonUI(ActionType.loans, action == ActionType.loans),
                      const SizedBox(
                        width: 16,
                      ),
                      getButtonUI(ActionType.other, action == ActionType.other),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget saccoProfileLogo() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Color.fromARGB(255, 252, 249, 249),
          child: Icon(
            Icons.account_circle_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // member personal information section
  Widget memberDetails(
    String userInfo,
  ) {
    return Flexible(
      child: Text(
        userInfo,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }

  //
  Widget recentActivityHeader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
          children: const [
            Text(
              'Member Recent Activities',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
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

  Widget getButtonUI(ActionType actionTypeData, bool isSelected) {
    String txt = '';
    if (ActionType.all == actionTypeData) {
      txt = 'All';
    } else if (ActionType.contributions == actionTypeData) {
      txt = 'Contributions';
    } else if (ActionType.loans == actionTypeData) {
      txt = 'Loans';
    } else if (ActionType.other == actionTypeData) {
      txt = 'Other';
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
                  top: 10, bottom: 10, left: 10, right: 10),
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

  Widget showOtherInfoHeader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
          children: const [
            Text(
              'About Member',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
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

  Widget showOtherInfo() {
    // show personal information that is public to members
    return Card(
      elevation: 5,
      child: Container(
        height: 30,
        width: 40,
      ),
    );
  }
}

// Display below recent activites for navigation
enum ActionType {
  all,
  contributions,
  loans,
  other,
}
