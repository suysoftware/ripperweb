import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'learn_content_desktop.dart';
import 'learn_content_mobile.dart';

class LearnView extends StatelessWidget {
  const LearnView({super.key});

  @override
  Widget build(BuildContext context) {
         return ScreenTypeLayout(
      mobile: const LearnContentMobile(),
      desktop: const LearnContentDesktop(),
    );
    
  }
}