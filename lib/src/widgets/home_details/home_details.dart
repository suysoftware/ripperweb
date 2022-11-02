import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ripper_web/src/constants/ripper_texts.dart';
import 'package:sizer/sizer.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        var textAlignment =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop
                ? TextAlign.left
                : TextAlign.center;
        double titleSize =
            sizingInformation.deviceScreenType == DeviceScreenType.mobile
                ? 50
                : 80;

        double descriptionSize =
            sizingInformation.deviceScreenType == DeviceScreenType.mobile
                ? 16
                : 21;

        return MouseRegion(
              cursor: SystemMouseCursors.none,
          child: SizedBox(
            width: 600,
            child: Column(
              //
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  RipperTexts.homeDetailsUp,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      fontSize: titleSize),
                  textAlign: textAlignment,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  RipperTexts.homeDetailsdown,
                  style: TextStyle(
                    fontSize: descriptionSize,
                    height: 1.7,
                  ),
                  textAlign: textAlignment,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
