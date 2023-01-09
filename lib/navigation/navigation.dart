import 'package:flutter/material.dart';
import 'package:saccofy/home/homepage.dart';
import 'package:saccofy/sacco/activate/create_sacco/add_sacco.dart';
import 'package:saccofy/sacco/details/feed/sacco_feed.dart';
import 'package:saccofy/sacco/notifications/new_notifications.dart';
import 'package:saccofy/user/settings/profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  final List<Widget> _classNavOptions = [
    const UserHomePage(),
    const SaccoFeed(),
    const NewNotifications(),
    const UserSettingsPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // final bool _isNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _classNavOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
    );
  }
}
