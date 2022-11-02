import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:ripper_web/src/views/contact/contact_content_desktop.dart';
import 'package:ripper_web/src/views/contact/contact_content_mobile.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});
 

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const ContactContentMobile(),
      desktop: const ContactContentDesktop(),
    );
  }
}
