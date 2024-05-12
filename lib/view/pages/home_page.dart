import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/gen/assets.gen.dart';
import 'package:flutter_plantist_app/view/components/custom_secondary_button.dart';
import 'package:flutter_plantist_app/view/helpers/theme.dart';
import 'package:flutter_plantist_app/view/pages/sign_in_page.dart';
import 'package:flutter_plantist_app/view/pages/sign_up_page.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Assets.images.mainIcon.image(),
          const SizedBox(height: 40),
          Text("Welcome back to", style: context.textTheme.largeTitleRegular),
          Text("Plantist", style: context.textTheme.largeTitleEmphasized),
          const SizedBox(height: 20),
          Text("Start your productive life now!",
              style: context.textTheme.bodyEmphasized
                  .copyWith(color: context.darkColor.shade200)),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSecondaryButton(
              onButtonPressed: (p0) {
                p0.push(SignInPage.routeName);
              },
              text: "Sign in with email",
              height: 75,
              enabled: true,
              icon: const Icon(Icons.mail),
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
          //const SizedBox(height: 100)
        ]),
      ),
    );
  }
}
