import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

TextStyle learnTextStyleHigh =
    const TextStyle(fontFamily: 'Roboto', fontSize: 40, color: Colors.black);
TextStyle learnTextStyleLow =
    const TextStyle(fontFamily: 'Roboto', color: Colors.black);

String learnText1 =
    "After humans were expelled from heaven, eternal life came to an end and the Ripper slowly began to exploit their souls. With the instinct to live, people sought ways of long life. The Ripper's archenemy, as well as the protector of humanity, has developed new techniques to fight him. The endless struggle has begun.";
String learnText2 =
    "Ripper was feeding on death, and against this, the lokman physician led humanity to share. With this technique, people could share their remaining lifespans with others. There were people who abused it, as in everything else, and they called themselves the masters of time. They took the side of Ripper against the sharing strategies of Lokman physician.";

String learnText3 =
    "The remaining lifetimes of all users are collected in a single pool. You can instantly check what percentage of life span you have.";

String learnText4 =
    "Join the roulette of life \n You have the right to be on the side of the wicked. If you want, you can join the roulette game at www.ripperdev.com. You may struggle to end other people's lifetimes";

String learnText5 =
    "Make the most of the lifetimes you have, You will have many opportunities to spend these lifetimes you have gained. Wait for events and spend as you please";

class LearnContentDesktop extends StatefulWidget {
  const LearnContentDesktop({super.key});

  @override
  State<LearnContentDesktop> createState() => _LearnContentDesktopState();
}

class _LearnContentDesktopState extends State<LearnContentDesktop> {
  late ScrollController _controller;
  double pixels = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();

    _controller.addListener(() {
      setState(() {
        pixels = _controller.position.pixels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          ripperTitleTextBuild(),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ripperLoreTextSideBuild(learnText1),
              ripperLoreImageBuild()
            ],
          ),
          mobileTextBuild('Mobile'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              animatorCase(ripperMobileHomeImageBuild(), true, 200),
              animatorCase(
                  ripperMobileHomeTextSideBuild(learnText2), false, 200),
            ],
          ),
          webGameTextBuild('Web Game'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              animatorCase(
                  ripperDesktopStatsTextSideBuild(learnText3), true, 750),
              animatorCase(ripperDesktopStatsImageBuild(), false, 750),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.h, 0.0, 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                animatorCase(ripperDesktopGameImageBuild(), true, 1350),
                animatorCase(
                    ripperDesktopGameTextSideBuild(learnText4), false, 1350),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0.0, 3.h, 0.0, 3.h),
              child: AnimatedOpacity(
                  opacity: pixels >= 1900 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: ripperSystemLoopBuild())),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 4.h, 0.0, 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                animatorCase(ripperWinTextSideBuild(learnText5), true, 2250),
                animatorCase(ripperWinImageBuild(), false, 2250),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 1.h, 0.0, 3.h),
            child: AnimatedOpacity(
              opacity: pixels >= 2600 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: AnimatedPadding(
                  duration: const Duration(milliseconds: 500),
                  padding: EdgeInsets.only(
                    top: pixels >= 2600 ? 0.0 : 300.0,
                  ),
                  child: ilionAndDesignerLogoBuild()),
            ),
          )
        ],
      ),
    );
  }

  Widget mobileTextBuild(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 12.h, 0.0, 3.h),
      child: Text(
        text,
        style: learnTextStyleHigh,
      ),
    );
  }

  Widget webGameTextBuild(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 12.h, 0.0, 3.h),
      child: Text(
        text,
        style: learnTextStyleHigh,
      ),
    );
  }

  Widget ripperLoreTextSideBuild(String ripperLoreText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 120,
          width: 350,
          child: AutoSizeText(
            ripperLoreText,
            style: learnTextStyleLow,
          ),
        ),
        Row(
          children: [
            forwardLinkButtonBuild(
                'assets/images/download_apple_store.png', 'APPLE'),
            forwardLinkButtonBuild(
                'assets/images/download_google_play.png', 'Android'),
          ],
        )
      ],
    );
  }

  Widget forwardLinkButtonBuild(String forwardName, String forwardLink) {
    return CupertinoButton(
        child: SizedBox(
            child: Image.asset(
          forwardName,
          scale: 1.7,
        )),

        /*   Text(
          forwardName,
          style: TextStyle(color: Colors.black, fontFamily: 'Roboto-Bold'),
        ),*/
        onPressed: () {
          //go => forwardLink
        });
  }

  Widget ripperLoreImageBuild() {
    return Image.asset(
      'assets/images/learn_images/learn_pic_1.png',
      height: 55.h,
      width: 35.w,
    );
  }

  Widget ripperMobileHomeImageBuild() {
    return Image.asset(
      'assets/images/learn_images/learn_pic_2.png',
      height: 55.h,
      width: 35.w,
    );
  }

  Widget ripperMobileHomeTextSideBuild(String ripperLoreText2) {
    return SizedBox(
      height: 170,
      width: 350,
      child: AutoSizeText(
        ripperLoreText2,
        style: learnTextStyleLow,
      ),
    );
  }

  Widget ripperDesktopStatsTextSideBuild(String ripperLoreText3) {
    return SizedBox(
      height: 170,
      width: 350,
      child: AutoSizeText(
        ripperLoreText3,
        style: learnTextStyleLow,
      ),
    );
  }

  Widget ripperDesktopStatsImageBuild() {
    return Image.asset(
      'assets/images/learn_images/learn_pic_3.png',
      height: 55.h,
      width: 35.w,
    );
  }

  Widget ripperDesktopGameImageBuild() {
    return Image.asset(
      'assets/images/learn_images/learn_pic_4.png',
      height: 55.h,
      width: 35.w,
    );
  }

  Widget ripperDesktopGameTextSideBuild(String ripperLoreText4) {
    return SizedBox(
      height: 170,
      width: 350,
      child: AutoSizeText(
        ripperLoreText4,
        style: learnTextStyleLow,
      ),
    );
  }

  Widget ripperSystemLoopBuild() {
    return Image.asset(
      'assets/images/learn_images/learn_pic_5.png',
      height: 55.h,
      width: 35.w,
    );
  }

  Widget ripperWinTextSideBuild(String ripperLoreText4) {
    return SizedBox(
      height: 170,
      width: 350,
      child: AutoSizeText(
        ripperLoreText4,
        style: learnTextStyleLow,
      ),
    );
  }

  Widget ripperWinImageBuild() {
    return Image.asset(
      'assets/images/learn_images/learn_pic_6.png',
      height: 55.h,
      width: 35.w,
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

  AnimatedOpacity animatorCase(
      Widget focusenWidget, bool isLeft, double pixelsValue) {
    return AnimatedOpacity(
        opacity: pixels >= pixelsValue ? 1.0 : 0.2,
        duration: const Duration(milliseconds: 500),
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 500),
          padding: isLeft
              ? EdgeInsets.only(
                  left: pixels >= pixelsValue ? 150.0 : 0.0,
                )
              : EdgeInsets.only(
                  right: pixels >= pixelsValue ? 150.0 : 0.0,
                ),
          child: focusenWidget,
        ));
  }

  Widget ripperTitleTextBuild() {
    return Text(
      'Ripper',
      style: learnTextStyleHigh,
    );
  }
}
