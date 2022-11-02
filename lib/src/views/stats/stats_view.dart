import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ripper_web/src/views/stats/stats_content_desktop.dart';
import 'package:ripper_web/src/views/stats/stats_content_mobile.dart';



class StatsView extends StatefulWidget {
  const StatsView({super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const StatsContentMobile(),
      desktop: const StatsContentDesktop(),
    );
  }
}
