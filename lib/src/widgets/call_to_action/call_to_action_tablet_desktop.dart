import 'package:flutter/material.dart';
import 'package:ripper_web/src/constants/app_colors.dart';


class CallToActionTabletDesktop extends StatelessWidget {
  final String title;
  const CallToActionTabletDesktop(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      decoration: BoxDecoration(
        color: themeGreen,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
    
        },
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
