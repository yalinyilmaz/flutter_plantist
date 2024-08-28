import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';

class AcceptTermsWidget extends StatelessWidget {
  const AcceptTermsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
                text: "By continuing, you agree to our",
                style: context.textTheme.subheadlineRegular.copyWith(
                    color: context.mainColor.shade300,
                    fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: ' Privacy Policy',
                    style: context.textTheme.subheadlineEmphasized
                        .copyWith(decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Here Privacy Policy will be shown
                      },
                  ),
                  TextSpan(
                    text: " and ",
                    style: context.textTheme.subheadlineRegular.copyWith(
                        color: context.mainColor.shade300,
                        fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: ' Terms of Use',
                    style: context.textTheme.subheadlineEmphasized
                        .copyWith(decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Here Terms of Use will be shown
                      },
                  ),
                ])),
      ),
    ]);
  }
}
