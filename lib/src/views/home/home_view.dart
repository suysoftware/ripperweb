import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ripper_web/src/views/home/home_content_desktop.dart';
import 'package:ripper_web/src/views/home/home_content_mobile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});



  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const HomeContentMobile(),
      desktop: const HomeContentDesktop(),
    );
  }
}
