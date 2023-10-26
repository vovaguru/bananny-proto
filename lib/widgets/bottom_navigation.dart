import 'package:flutter/material.dart';

import 'package:bananny/screens/apps.dart';
import '../screens/scribble.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  List<Widget> screenList = [
    AppsScreen(),
    const ScribbleScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.yellow,
      fixedColor: Colors.black,
      currentIndex: _selectedIndex, //New
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.apps),
          label: 'Приложения',
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => screenList[index]),
      // );
    });
  }
}
