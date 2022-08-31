import 'package:flutter/material.dart';

class NewNotifications extends StatelessWidget {
  const NewNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String notifications = '';
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.notifications),
        backgroundColor: Colors.pink[400],
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
