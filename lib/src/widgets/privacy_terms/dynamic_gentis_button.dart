import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
 // ignore: depend_on_referenced_packages
 import 'package:path/path.dart' as p;

var httpsUri = Uri(
    scheme: 'https',
    host: 'dynamicgentis.com',
   /* path: 'guides/libraries/library-tour',
    fragment: 'numbers'*/);

class DynamicGentisButton extends StatefulWidget {
  const DynamicGentisButton({super.key});

  @override
  State<DynamicGentisButton> createState() => _DynamicGentisButtonState();
}

class _DynamicGentisButtonState extends State<DynamicGentisButton> {
  launchURL() {
     launchUrl(p.toUri('https://www.dynamicgentis.com'));
   }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: launchURL,
        child: const Text(
          'Dynamic Gentis @ 2022',
          style: TextStyle(fontFamily: 'Roboto-Medium'),
        ));
  }
}
