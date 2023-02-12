import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewNotifications extends StatelessWidget {
  const NewNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String notifications = '';
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc()
              .collection('notifications')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Icon(
                Icons.notifications,
                size: 30,
              );
            }
            int count = snapshot.data!.docs.length;
            return Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    size: 20,
                  ),
                  onPressed: () {
                    // handle the press
                  },
                ),
                count != ''
                    ? Positioned(
                        right: 10,
                        top: 10,
                        child: Text(
                          count.toString(),
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ),
        backgroundColor: const Color(0xff1c3751),
        elevation: 10,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: const Center(
        child: Icon(
          Icons.notifications,
          size: 70,
        ),
      ),
    );
  }

  Widget viewNotifications() {
    return Center(
      child: Container(
        height: 30,
        width: 30,
        color: Colors.white,
        child: Column(
          children: [
            const Icon(
              Icons.notifications_outlined,
              size: 100,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.black,
              width: 30,
              height: 30,
              child: InkWell(
                onTap: () {},
                child: const Text('view'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget noNotifications() {
    return Center(
      child: Container(
        color: Colors.black,
        child: const Text('No Notifications Available'),
      ),
    );
  }
}
