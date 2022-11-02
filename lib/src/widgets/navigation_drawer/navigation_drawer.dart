import 'package:flutter/material.dart';
import 'package:ripper_web/src/routing/route_names.dart';
import 'package:ripper_web/src/widgets/navigation_drawer/drawer_item.dart';
import 'package:ripper_web/src/widgets/navigation_drawer/navigation_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: const <Widget>[
          NavigationDrawerHeader(),
          // BONUS: Combine the UI for this widget with the NavBarItem and make it responsive.
          // The UI for the current DrawerItem shows when it's in mobile, else it shows the NavBarItem ui.
          DrawerItem('Home', Icons.home, homeRoute),
          DrawerItem('Game', Icons.gamepad_rounded, gameRoute),
          DrawerItem('Stats', Icons.percent, statsRoute),
          DrawerItem('Learn', Icons.menu_book_outlined, learnRoute),
          DrawerItem('Contact', Icons.phone, contactRoute)
         
        ],
      ),
    );
  }
}