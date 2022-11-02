import 'package:flutter/material.dart';
import 'package:ripper_web/src/widgets/call_to_action/call_to_action.dart';
import 'package:ripper_web/src/widgets/home_details/home_details.dart';
import 'package:ripper_web/src/widgets/ripper_mascot/ripper_mascot.dart';

class HomeContentMobile extends StatefulWidget {
  const HomeContentMobile({Key? key}) : super(key: key);

  @override
  State<HomeContentMobile> createState() => _HomeContentMobileState();
}

class _HomeContentMobileState extends State<HomeContentMobile> {
    late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          HomeDetails(),
          SizedBox(
            height: 100,
          ),
          RipperMascot(),
             SizedBox(
            height: 50,
          ),
          CallToAction('Download App',),
        ],
      ),
    );
  }
}