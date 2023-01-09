import 'package:flutter/material.dart';

class MemberDetails extends StatefulWidget {
  const MemberDetails({Key? key}) : super(key: key);

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: const Text(
          "Member Info",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        elevation: 5,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // handle the press
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 250, 227, 235),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            // decoration: BoxDecoration(
                            //   boxShadow: [
                            //     BoxShadow(
                            //       color: Colors.grey.withOpacity(0.1),
                            //       spreadRadius: 1,
                            //       blurRadius: 7,
                            //       offset: const Offset(
                            //           0, 3), // changes position of shadow
                            //     ),
                            //   ],
                            // ),
                            child: SizedBox(
                              child: Card(
                                color: Colors.pink[50],
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                elevation: 3.0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 55.0, bottom: 20.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  "Total Contributions ",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          82, 95, 127, 1),
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "15,000",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          50, 50, 93, 1),
                                                      fontSize: 13.0),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 20.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                personalmemberContributionCard()
                                              ],
                                            ),
                                            const SizedBox(height: 10.0),
                                            const Divider(
                                              color: Colors.white,
                                              height: 40.0,
                                              thickness: .5,
                                              indent: 32.0,
                                              endIndent: 32.0,
                                            ),
                                            const SizedBox(height: 10.0),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0.0, left: 7.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  memberContributionCard(),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 300.0, right: 32.0),
                                              child: Align(
                                                child: Text("2022",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.w200)),
                                              ),
                                            ),
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
                          ),
                          const FractionalTranslation(
                            translation: Offset(0.0, -0.5),
                            child: Align(
                              alignment: FractionalOffset(0.5, 0.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/brian.jpeg"),
                                radius: 30.0,
                              ),
                            ),
                          )
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

  Widget personalmemberContributionCard() {
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
                        label: Text('Role', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Date Joined Sacco',
                            style: TextStyle(fontSize: 8))),
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
          height: MediaQuery.of(context).size.height * 0.16,
          child: Center(
            child: Column(
              children: <Widget>[
                DataTable(
                  columnSpacing: 35,
                  columns: const [
                    DataColumn(
                        label: Text('Mode', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Month', style: TextStyle(fontSize: 8))),
                    DataColumn(
                        label: Text('Contributions',
                            style: TextStyle(fontSize: 8))),
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
