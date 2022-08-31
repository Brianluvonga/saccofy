import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Activity",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(7),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('images/brian.jpeg'),
            ),
          )
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            left: 10,
            top: 160,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          updateProfile(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 145,
            right: 45,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          warningUpdateProfileIcon(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 55,
            top: 20,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: const <Widget>[
                        Text(
                          'Totals',
                          style: TextStyle(fontFamily: 'times'),
                        ),
                        // phoneNumber(),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 50,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      totalSaccos(),
                      SizedBox(height: 1),
                      contributionsCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 250,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        saccosCard(),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget totalSaccos() {
    return SizedBox(
      height: 70,
      width: 130,
      child: Card(
        elevation: 8.0,
        shadowColor: Colors.pink[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Total Saccos',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                '0',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contributionsCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      shadowColor: Colors.pink[300],
      child: Center(
        child: Container(
          height: 60,
          width: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.pink,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Contributions',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                '15,000',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget totalsCard() {
    return SizedBox(
      height: 300,
      width: 400,
      child: Card(
        elevation: 10,
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  left: 40,
                  top: 450,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[saccosCard()],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget saccoCard() {
    return SizedBox(
      height: 300,
      width: 380,
      child: Card(
        elevation: 10,
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  left: 40,
                  top: 450,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[saccosCard()],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profilePic() {
    return const CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage('images/brian.jpeg'),
    );
  }

  Widget warningUpdateProfileIcon() {
    return const Icon(
      Icons.warning,
      color: Colors.red,
      size: 15,
    );
  }

  Widget updateProfile() {
    return SizedBox(
      height: 40,
      width: 330,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Please Update Your Profile',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userName() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Brian Luvonga',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget emailAddress() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'brnluvonga@gmail.com',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget phoneNumber() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            '0798210403',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget saccosCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      // shadowColor: Colors.pink[300],
      child: Center(
        child: Container(
          height: 70,
          width: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            // color: Colors.pink,
          ),
          child: Stack(
            children: [
              Positioned(
                left: 140,
                top: 10,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: const <Widget>[
                              SizedBox(height: 55),
                              Text(
                                'Members',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(width: 65),
                              Text(
                                '15',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Column(
                  children: <Widget>[
                    saccoNameLayout(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 240,
                top: 55,
                child: Column(
                  children: <Widget>[
                    joinedDetails(),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget saccoNameLayout() {
    return SizedBox(
      height: 70,
      width: 70,
      child: Card(
        elevation: 8.0,
        // shadowColor: Colors.pink[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: const Center(
          child: Text(
            'Jijenge',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget joinedDetails() {
    return Center(
      child: Row(
        children: const [
          Text('Joined', style: TextStyle(fontSize: 10)),
          Text('12/12/2022', style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
