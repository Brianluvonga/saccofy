import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saccofy/home/homepage.dart';
import 'package:saccofy/sacco/activate/create_sacco/add_sacco.dart';
import 'package:saccofy/sacco/details/feed/sacco_feed.dart';
import 'package:saccofy/sacco/notifications/new_notifications.dart';
import 'package:saccofy/user/auth/firebase/auth_notifier.dart';
import 'package:saccofy/user/auth/firebase/user_model_notifier.dart';
import 'package:saccofy/user/settings/profile.dart';
import 'package:saccofy/user/settings/setting_screen.dart';

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
    const SettingsScreen()
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
        iconSize: 20,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle_outlined),
            label: 'Saccos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_sharp),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff1c3751),
        onTap: _onItemTapped,
      ),
    );
  }
}
