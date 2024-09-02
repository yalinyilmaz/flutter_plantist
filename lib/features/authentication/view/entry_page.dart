import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/gen/assets.gen.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:flutter_plantist_app/features/authentication/view/sign_in_page.dart';
import 'package:flutter_plantist_app/features/authentication/view/sign_up_page.dart';
import 'package:go_router/go_router.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Assets.images.logo.image(),
          const SizedBox(height: 40),
          Text("Welcome back to", style: context.textTheme.largeTitleRegular),
          Text("Connect", style: context.textTheme.largeTitleEmphasized),
          const SizedBox(height: 20),
          Text("Start your productive life now!",
              style: context.textTheme.bodyEmphasized
                  .copyWith(color: context.mainColor.shade400)),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomElevatedButton(
              onButtonPressed: (p0) {
                p0.push(SignInPage.routeName);
              },
              text: "Sign in with email",
              height: 75,
              enabled: true,
              icon: Icon(Icons.mail, color: globalCtx.whiteColor.shade100),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(TextSpan(
                  text: "Don't you have an account?",
                  style: context.textTheme.subheadlineRegular,
                  children: [
                    TextSpan(
                      text: ' Sign up',
                      style: context.textTheme.subheadlineEmphasized,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(SignUpPage.routeName);
                        },
                    )
                  ])),
            ],
          )
        ]),
      ),
    );
  }
}
