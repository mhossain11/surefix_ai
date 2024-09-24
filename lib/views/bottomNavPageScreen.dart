

import 'package:surefix_ai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:surefix_ai/views/Dashboard/dashboard.dart';

import '../utils/colors.dart';


class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
   Dashboard(),
   // AdminPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: colorTheme,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.6),

        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(
          // fontSize: ProjectResource.headerFontSize * 0.83,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(.6)),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          // fontSize: ProjectResource.headerFontSize * 0.93,
          color: Colors.white,
        ),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Documents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Mailbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
