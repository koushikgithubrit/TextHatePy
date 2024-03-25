import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        //home
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'HOME',
        ),

        //about
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'ABOUT',
        ),

        //settings
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'SETTING',
        ),

        //refresh
        BottomNavigationBarItem(
          icon: Icon(Icons.refresh),
          label: 'REFRESH',
        ),
      ],
    );
  }
}
