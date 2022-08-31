import 'package:flutter/material.dart';

class SaccoContrubutions extends StatefulWidget {
  const SaccoContrubutions({Key? key}) : super(key: key);

  @override
  State<SaccoContrubutions> createState() => _SaccoContrubutionsState();
}

class _SaccoContrubutionsState extends State<SaccoContrubutions> {
  String? header1 = "Finance Contributions";
  String? header2 = "Statistics";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Center(
          child: Text(
            "Sacco Contributions",
            style: TextStyle(fontSize: 16.5),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_sharp),
            onPressed: () {
              // handle the press
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.more_vert_sharp),
          onPressed: () {},
        ),
      ),
      body: Container(
        // color: Colors.pink[50],
        child: Stack(
          children: [
            Positioned(
              left: 35,
              top: 30,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            header(
                              header1.toString(),
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
              right: 143,
              top: 30,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            header(
                              header2.toString(),
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
              left: 30,
              top: 50,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            financeContributions(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 30,
              top: 50,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            statsRight(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 35,
              top: 290,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[
                        Text(
                          'Members',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 5,
              top: 305,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            individualContributionWidget(),
                          ],
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
    );
  }

  //=================== headers =================
  Widget header(String heading) {
    return Center(
      child: Text(
        heading,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget financeContributions() {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      shadowColor: Colors.white,
      child: Container(
        color: Colors.white,
        height: 200,
        width: 180,
        child: Stack(
          children: const [
            SingleChildScrollView(
              child: Card(
                elevation: 120,
                shadowColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statsRight() {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      shadowColor: Colors.white,
      child: Container(
        color: Colors.white,
        height: 200,
        width: 150,
        child: Stack(
          children: const [
            SingleChildScrollView(
              child: Card(
                elevation: 20,
                shadowColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

//display individuals contributions in a builder format
  Widget individualContributionWidget() {
    return Container(
      // color: Colors.pink[50],
      height: 350,
      width: 400,
      child: Column(children: [
        memberContributionCard(),
      ]),
    );
  }

  Widget memberContributionCard() {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      shadowColor: Colors.white,
      child: Container(
        height: 100,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height * 0.16,
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
                        label: Text('Month', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Amount', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Mode', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Status', style: TextStyle(fontSize: 8))),
                  ],
                  rows: const [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
