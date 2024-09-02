import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/app/components/custom_input_fields/custom_text_field.dart';
import 'package:flutter_plantist_app/app/dialogs/delete_account_dialog.dart';
import 'package:flutter_plantist_app/app/dialogs/logout_dialog.dart';
import 'package:flutter_plantist_app/features/authentication/model/auth_status_model.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  ValueNotifier<bool> isEditing = ValueNotifier<bool>(false);
  ValueNotifier<String> email = ValueNotifier<String>(
      FirebaseAuth.instance.currentUser?.email ?? "User not found");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: isEditing,
                builder: (context, editing, _) {
                  if (editing) {
                    return Column(
                      children: [
                        CustomTextField(
                          controller: TextEditingController(text: email.value),
                          onChanged: (value) {
                            email.value = value;
                          },
                          hintText: "edit e-mail",
                          isObscured: false,
                        ),
                        const SizedBox(height: 10),
                        CustomElevatedButton(
                          onButtonPressed: (p0) async {
                            // this process requires verification before updates so that it does not work just visually works
                            // await FirebaseAuth.instance.currentUser
                            //     ?.verifyBeforeUpdateEmail(email.value);
                            isEditing.value = false;
                          },
                          buttonSize: ButtonSize.small,
                          isPrimary: true,
                          text: "Save",
                        ),
                      ],
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        isEditing.value = true;
                      },
                      child: Text(
                        email.value,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    );
                  }
                },
              ),
              const Spacer(),
              CustomElevatedButton(
                onButtonPressed: (p0) async {
                  final isApproved = await showLogoutDialog(context);
                  if (isApproved) {
                    appBloc.logout();
                  }
                },
                isPrimary: false,
                text: "Logout",
              ),
              const SizedBox(
                height: 5,
              ),
              CustomElevatedButton(
                onButtonPressed: (p0) async {
                  final isApproved = await showDeleteAccountDialog(context);
                  if (isApproved) {
                    appBloc.deleteAccount();
                  }
                },
                isPrimary: false,
                text: "Delete Account",
              )
            ],
          )),
    );
  }
}
