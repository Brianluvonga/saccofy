import 'package:flutter/material.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text(
            "Members Feed",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ),
      ),
      backgroundColor: const Color(0xff0f000b),
      body:
          // height: size.height,
          Stack(
        children: [
          Container(
            height: size.height * 0.30,
            color: Colors.white,
          ),
          Positioned(
            top: 60.0,
            left: 100,
            // width: size.width,
            child: saccoTitle(),
          ),
        ],
      ),
    );
  }

  final List<String> imageUrls = [
    'https://picsum.photos/200/300',
    'https://picsum.photos/200/301',
    'https://picsum.photos/200/302',
    'https://picsum.photos/200/303',
    'https://picsum.photos/200/304',
    'https://picsum.photos/200/305',
  ];

  Widget membersFeed() {
    return Wrap(
      spacing: 8.0, // gap between adjacent items
      runSpacing: 4.0, // gap between lines
      children: List.generate(
        imageUrls.length,
        (index) {
          return Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrls[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget saccoTitle() {
    return Center(
      child: Column(
        children: const [
          CircleAvatar(
            radius: 35,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Sacco Title',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text("This are the Members of the Sacco")
        ],
      ),
    );
  }
}
