import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:ripper_web/src/views/game/game_content_desktop.dart';
import 'package:ripper_web/src/views/game/game_content_mobile.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const GameContentMobile(),
      desktop: const GameContentDesktop(),
    );
  }
}
