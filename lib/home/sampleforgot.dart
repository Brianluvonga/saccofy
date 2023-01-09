import 'package:flutter/material.dart';

class SampleOne extends StatefulWidget {
  const SampleOne({super.key});

  @override
  _SampleOneState createState() => _SampleOneState();
}

class _SampleOneState extends State<SampleOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 120.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70.0,
                    width: 70.0,
                    child: Image.network(
                      'https://pbs.twimg.com/profile_images/1116377989366517761/jJZl1D_Y_400x400.jpg',
                    ),
                  ),
                  Text('Member 1'),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 120.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70.0,
                    width: 70.0,
                    child: Image.network(
                      'https://pbs.twimg.com/profile_images/1116377989366517761/jJZl1D_Y_400x400.jpg',
                    ),
                  ),
                  Text('Member 2'),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 120.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70.0,
                    width: 70.0,
                    child: Image.network(
                      'https://pbs.twimg.com/profile_images/1116377989366517761/jJZl1D_Y_400x400.jpg',
                    ),
                  ),
                  Text('Member 2'),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 120.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70.0,
                    width: 70.0,
                    child: Image.network(
                      'https://pbs.twimg.com/profile_images/1116377989366517761/jJZl1D_Y_400x400.jpg',
                    ),
                  ),
                  Text('Member 2'),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
