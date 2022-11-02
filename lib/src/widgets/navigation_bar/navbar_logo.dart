import 'package:flutter/material.dart';
import 'package:ripper_web/src/routing/route_names.dart';

import '../../locator.dart';
import '../../services/navigation_service.dart';

class NavBarLogo extends StatelessWidget {
  const NavBarLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: () {
        locator<NavigationService>().navigateTo(homeRoute);
      },
      child: SizedBox(
        height: 100,
        width: 160,
        child: Image.asset('assets/images/ripper_home_icon.png'),
      ),
    );
  }
}
