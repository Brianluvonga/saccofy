import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/sacco/api/sacco_api.dart';
import 'package:saccofy/sacco/notifier/sacco_notifier.dart';

class SaccoInfoScreen extends StatefulWidget {
  const SaccoInfoScreen({Key? key}) : super(key: key);

  @override
  _SaccoInfoScreenState createState() => _SaccoInfoScreenState();
}

class _SaccoInfoScreenState extends State<SaccoInfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  // Widget memberWidget() {
  //   return FutureBuilder(
  //     future: getSaccoMembers(),
  //     builder: (BuildContext context, snapshot) {
  //       if (snapshot.hasData) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         } else {
  //           return Center(
  //             // here only return is missing
  //             child: Text(snapshot.data!.toString()),
  //           );
  //         }
  //       } else if (snapshot.hasError) {
  //         Text('no data');
  //       }
  //       return CircularProgressIndicator(
  //         color: Colors.pink,
  //         strokeWidth: 2,
  //       );
  //     },
  //   );
  // }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  //widget to display total number of members in the sacco

  Widget saccoGrid() {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: saccoNotifier.saccoList.length,
      itemBuilder: (BuildContext ctx, index) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            title: Text(saccoNotifier.saccoList[index].saccoName.toString(),
                style: const TextStyle(fontSize: 12)),
            subtitle:
                Text(saccoNotifier.saccoList[index].aboutSacco.toString()),
            leading: const Icon(
              Icons.image_rounded,
              size: 35,
            ),
            trailing: Text(saccoNotifier.saccoList[index].purpose.toString()),
            onTap: () {
              saccoNotifier.currentSacco = saccoNotifier.saccoList[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const SaccoInfoScreen();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SaccoNotifier saccoNotifier =
        Provider.of<SaccoNotifier>(context, listen: false);
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: Colors.pink[100],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Positioned(
              // left: 20,
              // top: 50,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      height: 150,
                    ),
                    Text(
                      'Sacco Name: ${saccoNotifier.currentSacco.saccoName}',
                      style: TextStyle(fontSize: 20),
                    ),
                    const AspectRatio(
                      aspectRatio: 1.2,
                      // child: saccoGrid(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight,
                          maxHeight: tempHeight > infoHeight
                              ? tempHeight
                              : infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 32.0, left: 18, right: 16),
                            child: Text(
                              'Sacco\n  Members',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                letterSpacing: 0.27,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  'Total Members',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 20,
                                    letterSpacing: 0.20,
                                    color: Colors.black87,
                                  ),
                                ),
                                // ignore: avoid_unnecessary_containers
                                //
                              ],
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  // memberWidget(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  getTimeBoxUI('2hours', 'Time'),
                                  getTimeBoxUI('24', 'Seat'),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                                child: Text(
                                  'Contributions',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    letterSpacing: 0.27,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const <Widget>[
                                  // Container(
                                  //   width: 48,
                                  //   height: 48,
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.white,
                                  //       borderRadius: const BorderRadius.all(
                                  //         Radius.circular(16.0),
                                  //       ),
                                  //       border: Border.all(
                                  //           color:
                                  //               Colors.grey.withOpacity(0.2)),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
              right: 35,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController!, curve: Curves.fastOutSlowIn),
                child: Card(
                  color: Colors.pink[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: const Center(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget memberCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              saccoGrid(),
              // Text(
              //   text1,
              //   textAlign: TextAlign.center,
              //   style: const TextStyle(
              //       fontWeight: FontWeight.w600,
              //       fontSize: 14,
              //       letterSpacing: 0.27,
              //       color: Colors.lightBlue),
              // ),
              // Text(
              //   txt2,
              //   textAlign: TextAlign.center,
              //   style: const TextStyle(
              //     fontWeight: FontWeight.w200,
              //     fontSize: 14,
              //     letterSpacing: 0.27,
              //     color: Colors.grey,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 0.27,
                    color: Colors.lightBlue),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
