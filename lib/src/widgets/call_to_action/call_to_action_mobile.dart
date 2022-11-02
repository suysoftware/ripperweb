// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:ripper_web/src/constants/app_colors.dart';

class CallToActionMobile extends StatelessWidget {
  final String title;
  const CallToActionMobile(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(31, 31, 31, 1),
        ),
      ),
      decoration: BoxDecoration(
        color: themeGreen,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
