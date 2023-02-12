import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationSection extends StatefulWidget {
  final String saccoId;
  final String memberId;

  const NotificationSection(
      {Key? key, required this.saccoId, required this.memberId})
      : super(key: key);

  @override
  _NotificationSectionState createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection> {
  int _unreadNotificationsCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var firestore = FirebaseFirestore.instance;
    var unreadNotifications = await firestore
        .collection('sacco')
        .doc(widget.saccoId)
        .collection('notification')
        .where('memberId', isEqualTo: widget.memberId)
        .where('isRead', isEqualTo: false)
        .get();
    setState(
      () {
        _unreadNotificationsCount = unreadNotifications.docs.length;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Icon(Icons.notifications),
          _unreadNotificationsCount == 0
              ? Container()
              : Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      '$_unreadNotificationsCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
