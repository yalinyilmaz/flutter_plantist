
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/app/components/terrms_of_use.dart';
import 'package:flutter_plantist_app/app/components/custom_input_fields/custom_text_field.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/sign_up_page';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {

  late TextEditingController mailTextController;
  late TextEditingController passwordTextController;
  late final GlobalKey<FormState> formKey;
  late bool isEnable;

  @override
  void initState() {
    super.initState();
    mailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    formKey = GlobalKey<FormState>();
    isEnable = false;
    handleAuthErrors();
  }


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
                  GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const SizedBox(child: Icon(Icons.arrow_back_ios)))
                ]),
              ),
              Row(children: [
                Text("Sign up with email",
                    style: context.textTheme.title1Emphasized)
              ]),
              const SizedBox(height: 15),
              Row(children: [
                Text("Enter your email and password",
                    style: context.textTheme.calloutEmphasized
                        .copyWith(color: context.mainColor.shade400)),
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
                        if (value.isEmpty) {
                          return "This field is mandatory";
                        }
                        if (value.length < 4 || !value.contains("@")) {
                          return "Invalid E-mail address ";
                        }
                      },
                      onChanged: (String value) {
                        mailTextController.text = value;
                        _isSignUpBtnEnable();
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
                        if (value.isEmpty) {
                          return "This field is mandatory";
                        }
                        if (value.length < 6) {
                          return "Password should be at least 6 characters long";
                        }
                      },
                      onChanged: (String value) {
                        passwordTextController.text = value;
                        _isSignUpBtnEnable();
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomElevatedButton(
                      height: 75,
                      text: "Create Account",
                      enabled: _isSignUpBtnEnable(),
                      onButtonPressed: (p0) {
                        final email = mailTextController.text;
                        final password = passwordTextController.text;
                        appBloc.register(email, password);
                      },
                    ),
                    const SizedBox(height: 15),
                    const AcceptTermsWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isSignUpBtnEnable() {
    isEnable = formKey.currentState?.validate() ?? false;
    setState(() {});
    return isEnable;
  }
}
