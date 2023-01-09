import 'package:flutter/material.dart';
import 'package:saccofy/home/sampleforgot.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          height: size.height,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.25,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1.066, 1.0),
                    end: Alignment(2.305, -2.078),
                    colors: [Color(0xffd69cc8), Color(0xff0e7bdc)],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
              Positioned(
                top: 70.0,
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
                top: 140.0,
                width: size.width,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      numbersCard(),
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: "Have some\nproblem with",
                      //         style: TextStyle(
                      //           height: 1.4,
                      //           fontSize: 30.0,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: " your Device?",
                      //         style: TextStyle(
                      //           fontSize: 30.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // LoginForm(),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 300.0,
                width: size.width,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      totalDeposits(),
                      // RichText(
                      //   text: TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: "Have some\nproblem with",
                      //         style: TextStyle(
                      //           height: 1.4,
                      //           fontSize: 30.0,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: " your Device?",
                      //         style: TextStyle(
                      //           fontSize: 30.0,
                      //           fontWeight: FontWeight.w600,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // LoginForm(),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 500.0,
                width: size.width,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      personalSavings(),
                      SizedBox(
                        height: 20.0,
                      ),
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

  Widget numbersCard() {
    return Container(
      // width: 250,
      // height: 130,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.white54,
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: const [
                  Text(
                    'Saccos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '4',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                children: const [
                  Text(
                    'Loans',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '4',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                children: const [
                  Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '28',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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

  Widget welcomeMsg() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: const Text(
            'Welcome ' + 'Brian Luvonga',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget totalDeposits() {
    return Container(
      height: 150,
      width: 10,
      decoration: BoxDecoration(
        color: Colors.teal[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.teal,
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'Total Deposits',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '\$1,000',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget personalSavings() {
    return Container(
      height: 150,
      width: 90,
      decoration: BoxDecoration(
        color: Colors.indigo[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.indigo,
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'Personal Savings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '\$500',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget recordsSection() {
    var onPressedB;
    return Center(
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 248, 142, 177),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Row(
            children: const [
              Text(
                'View Your Records',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Icon(Icons.arrow_right_alt)
            ],
          ),
        ),
      ),
    );
  }

  Widget saccoMembers() {
    final List<GroupMember> groupMembers = [
      GroupMember(name: 'Alice', imageUrl: 'https://example.com/alice.jpg'),
      GroupMember(name: 'Bob', imageUrl: 'https://example.com/bob.jpg'),
      GroupMember(name: 'Charlie', imageUrl: 'https://example.com/charlie.jpg'),
      GroupMember(name: 'Dave', imageUrl: 'https://example.com/dave.jpg'),
      GroupMember(name: 'Eve', imageUrl: 'https://example.com/eve.jpg'),
      GroupMember(name: 'Frank', imageUrl: 'https://example.com/frank.jpg'),
      GroupMember(name: 'Gina', imageUrl: 'https://example.com/gina.jpg'),
      GroupMember(name: 'Harry', imageUrl: 'https://example.com/harry.jpg'),
    ];

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: groupMembers.map((member) {
          return Container(
            child: Column(
              children: [
                Image.network(member.imageUrl),
                Text(member.name),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class GroupMember {
  String name;
  String imageUrl;

  GroupMember({required this.name, required this.imageUrl});
}
