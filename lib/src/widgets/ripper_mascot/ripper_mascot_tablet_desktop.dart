import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RipperMascotTabletDesktop extends StatelessWidget {
  const RipperMascotTabletDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      child: Image.asset(
        'assets/images/ripper_mascot.png',
      ),
    );
  }
}
