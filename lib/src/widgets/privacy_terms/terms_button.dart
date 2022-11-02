import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ripper_web/src/widgets/privacy_terms/policy_button.dart';



class TermsOfUse extends StatelessWidget {
  const TermsOfUse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(

         style: const TextStyle(fontFamily: 'Roboto-Medium'),
          children: [     TextSpan(
            
              text: "Privacy Policy",
              style: const TextStyle(fontFamily: 'Roboto-Medium'),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'privacy_policy.md',
                      );
                    },
                  );
                },
            ),
                         const TextSpan(text:" • "),
            TextSpan(
              text: "Terms",
                style: const TextStyle(fontFamily: 'Roboto-Medium'),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return PolicyDialog(
                          mdFileName: 'terms_and_conditions.md',
                        );
                      });
                },
            ),

      
          ],
        ),
      ),
    );
  }
}
