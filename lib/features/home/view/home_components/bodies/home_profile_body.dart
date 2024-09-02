import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/app/components/custom_input_fields/custom_text_field.dart';
import 'package:flutter_plantist_app/app/dialogs/delete_account_dialog.dart';
import 'package:flutter_plantist_app/app/dialogs/logout_dialog.dart';

import 'package:image_picker/image_picker.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final picker = ImagePicker();
  File? image;
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
              StreamBuilder<String?>(
                stream: appBloc.profilePhotoUrl,
                builder: (context, snap) {
                  if (snap.hasData && snap.data != null) {
                    final profilePhotoUrl = snap.data!;
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profilePhotoUrl),
                    );
                  } else {
                    return const CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 50,
                      ),
                    );
                  }
                },
              ),
              TextButton(
                  onPressed: () async {
                    await getImage(ImageSource.gallery);
                    if (image != null) {
                    appBloc.createPhoto(image!,"",isProfilePhoto: true);
                    }
                  },
                  child: const Text("Add/Update Profile Photo")),
              const SizedBox(height: 5),
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

  Future<void> getImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }
}
