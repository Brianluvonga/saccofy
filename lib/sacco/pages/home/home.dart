import 'package:flutter/material.dart';
import 'package:saccofy/home/sampleforgot.dart';

class SaccoHomePage extends StatefulWidget {
  const SaccoHomePage({super.key});

  @override
  State<SaccoHomePage> createState() => _SaccoHomePageState();
}

class _SaccoHomePageState extends State<SaccoHomePage> {
  // Initiate what is to be seen
  ActionType action = ActionType.all;
  //
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1c3751),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          height: size.height,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.25,
                color: const Color(0xff1c3751),
              ),
              Positioned(
                top: 70.0,
                left: -100,
                width: size.width,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      welcomeMsg(),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 210.0,
                left: -30,
                width: size.width,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      recentActivityHeader(),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 260.0,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: <Widget>[
                      getButtonUI(ActionType.all, action == ActionType.all),
                      const SizedBox(
                        width: 16,
                      ),
                      getButtonUI(
                          ActionType.messages, action == ActionType.messages),
                      const SizedBox(
                        width: 16,
                      ),
                      getButtonUI(ActionType.loans, action == ActionType.loans),
                      const SizedBox(
                        width: 16,
                      ),
                      getButtonUI(ActionType.contributions,
                          action == ActionType.contributions),
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

  Widget scrollableSaccoActions() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.access_alarm),
        Icon(Icons.access_time),
        Icon(Icons.add),
        Icon(Icons.add_a_photo),
      ],
    );
  }

  Widget welcomeMsg() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Column(
            children: const [
              Text(
                'Total Contributions',
                style: TextStyle(fontSize: 12, color: Colors.white60),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Kshs. 20,000',
                style: TextStyle(
                    fontSize: 22, color: Color.fromARGB(153, 143, 142, 142)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget recentActivities() {}

  Widget recentActivityHeader() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Row(
          children: const [
            Text(
              'Recent Activities',
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
    } else if (ActionType.messages == actionTypeData) {
      txt = 'Messages';
    } else if (ActionType.loans == actionTypeData) {
      txt = 'Loans';
    } else if (ActionType.contributions == actionTypeData) {
      txt = 'Contributions';
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
}

class GroupMember {
  String name;
  String imageUrl;

  GroupMember({required this.name, required this.imageUrl});
}

// Display below recent activites for navigation
enum ActionType {
  all,
  messages,
  loans,
  contributions,
}
