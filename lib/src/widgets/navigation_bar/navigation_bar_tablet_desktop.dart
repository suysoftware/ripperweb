import 'package:flutter/material.dart';
import 'package:ripper_web/src/routing/route_names.dart';
import 'navbar_item.dart';
import 'navbar_logo.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              NavBarItem('Home', homeRoute),
              SizedBox(
                width: 30,
              ),
              NavBarItem('Game', gameRoute),
              SizedBox(
                width: 30,
              ),
              NavBarItem('Stats', statsRoute),
              SizedBox(
                width: 30,
              ),
              NavBarItem('Learn', learnRoute),
              SizedBox(
                width: 30,
              ),
               NavBarItem('Contact', contactRoute),
              SizedBox(
                width: 30,
              ),
            ],
          )
        ],
      ),
    );
  }
}
