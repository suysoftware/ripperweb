import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/privacy_terms/terms_button.dart';

class ContactContentMobile extends StatefulWidget {
  const ContactContentMobile({super.key});

  @override
  State<ContactContentMobile> createState() => _ContactContentMobileState();
}

class _ContactContentMobileState extends State<ContactContentMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(
          flex: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            contactPartBuild(),

            // Text( "______________________",style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 7.sp),),
            SizedBox(
              width: 20.w,
            ),

            legalPartBuild(),
          ],
        ),
        ilionAndDesignerLogoBuild(),
        const Spacer(
          flex: 1,
        )
      ],
    );
  }


  Widget contactPartBuild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "CONTACT",
          style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 12.sp),
        ),
        Text(
          " • ",
          style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 10.sp),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          "info@ripperdev.com",
          style: TextStyle(fontFamily: 'Roboto', fontSize: 4.sp),
        ),
      ],
    );
  }

  Widget legalPartBuild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "LEGAL",
          style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 12.sp),
        ),
        Text(
          " • ",
          style: TextStyle(fontFamily: 'Roboto-Bold', fontSize: 10.sp),
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            TermsOfUse(),
          ],
        ),
      ],
    );
  }

  Widget ilionAndDesignerLogoBuild() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Image.asset(
        'assets/images/learn_images/learn_pic_7.png',
        scale: 1.5,
      ),
    );
  }
}