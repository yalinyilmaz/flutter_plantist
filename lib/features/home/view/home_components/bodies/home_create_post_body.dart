import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/app/components/custom_input_fields/custom_text_field.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:flutter_plantist_app/core/button_animation/animated_fade_button.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostBody extends StatefulWidget {
  const CreatePostBody({super.key});

  @override
  State<CreatePostBody> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreatePostBody> {
  final picker = ImagePicker();
  File? image;
  final TextEditingController captionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SizedBox(height: 5),
            AnimatedFadeButton(
              onTap: () {
                if (image != null) {
                  appBloc.createPhoto(image!, captionTextController.text);
                }
              },
              child: Text(
                "Add Photo",
                style: context.textTheme.title3Emphasized
                    .copyWith(color: context.mainColor.shade400),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.sizeOf(context).height / 2,
              decoration: BoxDecoration(
                  border: Border.all(color: globalCtx.mainColor.shade500),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  image != null
                      ? Image.file(
                          image!,
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        )
                      : Column(
                          children: [
                            Icon(
                              Icons.add,
                              color: globalCtx.mainColor.shade500,
                              size: 55,
                            ),
                          ],
                        ),
                  const Spacer(),
                  CustomTextField(
                    hintText: "Enter caption",
                    isObscured: false,
                    onChanged: (value) {
                      captionTextController.text = value;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            AnimatedFadeButton(
              onTap: () {
                getImage(ImageSource.camera);
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: globalCtx.mainColor.shade500),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.add_a_photo,
                    color: globalCtx.whiteColor.shade100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
                buttonSize: ButtonSize.large,
                text: "Pick Image From Gallery",
                enabled: true,
                isPrimary: true,
                onButtonPressed: (value) async {
                  await getImage(ImageSource.gallery);
                }),
          ],
        ),
      ),
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
