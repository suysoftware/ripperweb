import 'package:flutter/material.dart';
import 'package:ripper_web/src/widgets/call_to_action/call_to_action.dart';
import 'package:ripper_web/src/widgets/home_details/home_details.dart';
import 'package:ripper_web/src/widgets/ripper_mascot/ripper_mascot.dart';
import 'package:sizer/sizer.dart';

class HomeContentDesktop extends StatelessWidget {
  const HomeContentDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.h,
            ),
            const HomeDetails(),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CallToAction('Download App'),
              ],
            ),
          ],
        ),
       const RipperMascot(),
      ],
    );
  }
}
