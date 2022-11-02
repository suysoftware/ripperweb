import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ripper_web/src/widgets/ripper_mascot/ripper_mascot_mobile.dart';
import 'package:ripper_web/src/widgets/ripper_mascot/ripper_mascot_tablet_desktop.dart';

class RipperMascot extends StatelessWidget {
  const RipperMascot({super.key});

  @override
   Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:const RipperMascotMobile() ,
      tablet: const RipperMascotTabletDesktop(),
    );
  }
}