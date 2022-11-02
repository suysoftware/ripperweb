import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RipperMascotMobile extends StatelessWidget {
  const RipperMascotMobile({super.key});

  @override
  Widget build(BuildContext context) {
      return Container(
      height:20.h,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/ripper_mascot.png',
      ),
    );
  }
}
