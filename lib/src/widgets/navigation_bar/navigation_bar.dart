import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ripper_web/src/widgets/navigation_bar/navigation_bar_tablet_desktop.dart';
import 'package:ripper_web/src/widgets/navigation_bar/navigation_bar_mobile.dart';


class NavigatiorBar extends StatelessWidget {
  const NavigatiorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const NavigationBarMobile(),
      tablet: const NavigationBarTabletDesktop(),
    );
  }
}