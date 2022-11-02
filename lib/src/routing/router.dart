// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ripper_web/src/routing/route_names.dart';
import 'package:ripper_web/src/views/home/home_view.dart';
import '../views/contact/contact_view.dart';
import '../views/download/download_view.dart';
import '../views/game/game_view.dart';
import '../views/learn/learn_view.dart';
import '../views/stats/stats_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return _getPageRoute(HomeView(), settings.name.toString());
    case gameRoute:
      return _getPageRoute(GameView(), settings.name.toString());
    case statsRoute:
      return _getPageRoute(StatsView(), settings.name.toString());
    case learnRoute:
      return _getPageRoute(LearnView(), settings.name.toString());
    case downloadRoute:
      return _getPageRoute(DownloadView(), settings.name.toString());
    case contactRoute:
      return _getPageRoute(ContactView(), settings.name.toString());
    default:
      return _getPageRoute(HomeView(), settings.name.toString());
  }
}

PageRoute _getPageRoute(Widget child, String routeName) {
  return _FadeRoute(child: child, routeName: routeName);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({required this.child, required this.routeName})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                child,
            settings: RouteSettings(name: routeName),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}

