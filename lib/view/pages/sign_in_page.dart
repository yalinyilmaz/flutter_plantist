import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_plantist_app/view/components/custom_primary_button.dart';
import 'package:flutter_plantist_app/view/components/custom_text_field.dart';
import 'package:flutter_plantist_app/view/helpers/theme.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_in_page';
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

final formKey = GlobalKey<FormState>();

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 5),
                child: Row(children: [
                  GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const SizedBox(child: Icon(Icons.arrow_back_ios)))
                ]),
              ),
              Row(children: [
                Text("Sign in with email",
                    style: context.textTheme.title1Emphasized)
              ]),
              const SizedBox(height: 15),
              Row(children: [
                Text("Enter your email and password",
                    style: context.textTheme.calloutEmphasized
                        .copyWith(color: context.darkColor.shade300)),
              ]),
              const SizedBox(height: 40),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      isObscured: false,
                      hintText: "E-mail",
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "This field is mandatory";
                        }
                        if (value.length < 4 || !value.contains("@")) {
                          return "Invalid E-mail address ";
                        }
                      },
                      onChanged: () {
                        formKey.currentState!.validate();
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      suffixIcon: const Icon(CupertinoIcons.eye_slash),
                      isObscured: true,
                      hintText: "Password",
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "This field is mandatory";
                        }
                        if (value.length < 7) {
                          return "Password should be at least 6 characters long";
                        }
                      },
                      onChanged: () {
                        formKey.currentState!.validate();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //can go to Forgot Password page
                            },
                            child: Text("Forgot Password?",
                                style: context.textTheme.subheadlineEmphasized
                                    .copyWith(color: Colors.blueAccent)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomPrimaryButton(
                      height: 75,
                      text: "Sign In",
                      enabled: _isSignInBtnEnable(),
                      onButtonPressed: (p0) {

                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Expanded(
                          child: Text.rich(
                            textAlign:TextAlign.center ,
                            TextSpan(
                            text: "By continuing, you agree to our",
                            style: context.textTheme.subheadlineRegular.copyWith(
                                color: context.darkColor.shade300, fontWeight: FontWeight.w400),
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
                                color: context.darkColor.shade300, fontWeight: FontWeight.w400),),
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
                        ),]
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool  _isSignInBtnEnable() {

    final isEnable = formKey.currentState?.validate() ?? false;
    setState(() {});

    return isEnable;
  } 
}
