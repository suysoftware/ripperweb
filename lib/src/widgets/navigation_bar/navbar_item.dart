import 'package:flutter/material.dart';
import 'package:ripper_web/src/locator.dart';
import 'package:ripper_web/src/services/navigation_service.dart';
import 'package:sizer/sizer.dart';

class NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;

  const NavBarItem(
    this.title,
    this.navigationPath, {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        locator<NavigationService>().navigateTo(navigationPath);
      },
      child: Text(
        title,
        style: TextStyle(
            fontSize: 100.w < 1000 ? 6.sp : 4.sp,
            fontFamily: "Roboto",
            fontWeight: locator<NavigationService>()
                        .navigatorKey
                        .currentContext
                        .toString() ==
                    title
                ? FontWeight.bold
                : FontWeight.w100),
      ),
    );
  }
}
