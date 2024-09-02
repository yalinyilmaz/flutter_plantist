import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/app/components/terrms_of_use.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/core/button_animation/animated_fade_button.dart';
import 'package:flutter_plantist_app/app/components/custom_input_fields/custom_text_field.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_in_page';
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
// late final AppBloc appBloc;

   @override
  void initState() {
    super.initState();
    handleAuthErrors();
  }



  TextEditingController mailTextController = TextEditingController(text: "yy@gmail.com");
  TextEditingController passwordTextController =
      TextEditingController(text: "123456");
  final formKey = GlobalKey<FormState>();
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 5),
                child: Row(children: [
                  AnimatedFadeButton(
                      onTap: () {
                        context.pop();
                      },
                      child: SizedBox(
                          child: Icon(Icons.arrow_back_ios,
                              color: globalCtx.mainColor.shade500)))
                ]),
              ),
              Row(children: [
                Text("Sign in with email",
                    style: context.textTheme.title1Emphasized)
              ]),
              const SizedBox(height: 15),
              Row(children: [
                Text("Enter your email and password",
                    style: context.textTheme.calloutEmphasized),
              ]),
              const SizedBox(height: 40),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: mailTextController,
                      isObscured: false,
                      hintText: "E-mail",
                      validator: (String value) {
                        return MultiValidator([
                          EmailValidator(errorText: "Invalid e_mail adress"),
                          RequiredValidator(
                              errorText: "This field is mandatory"),
                        ]).call(value);
                      },
                      onChanged: (String value) {
                        mailTextController.text = value;
                        _isSignInBtnEnable();
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: passwordTextController,
                      suffixIcons: const [
                        Icon(CupertinoIcons.eye),
                        Icon(CupertinoIcons.eye_slash)
                      ],
                      isObscured: true,
                      hintText: "Password",
                      validator: (String value) {
                        return MultiValidator([
                          MinLengthValidator(5,
                              errorText:
                                  "Password should be at least 6 characters long"),
                          RequiredValidator(
                              errorText: "This field is mandatory"),
                        ]).call(value);
                      },
                      onChanged: (String value) {
                        passwordTextController.text = value;
                        _isSignInBtnEnable();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedFadeButton(
                            onTap: () {
                              //can go to Forgot Password page
                            },
                            child: Text("Forgot Password?",
                                style: context.textTheme.subheadlineEmphasized
                                    .copyWith(
                                        color: globalCtx.mainColor.shade500)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomElevatedButton(
                      isPrimary: true,
                      height: 75,
                      text: "Sign In",
                      enabled: _isSignInBtnEnable(),
                      onButtonPressed: (p0) {
                        final email = mailTextController.text;
                        final password = passwordTextController.text;
                        appBloc.login(email, password);
                      },
                    ),
                    const SizedBox(height: 15),
                    const AcceptTermsWidget()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isSignInBtnEnable() {
    isEnable = formKey.currentState?.validate() ?? false;
    setState(() {});
    return isEnable;
  }
}
