import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/app/components/custom_input_fields/custom_text_field.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostBody extends StatefulWidget {
  const CreatePostBody({super.key});

  @override
  State<CreatePostBody> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CreatePostBody> {
  final picker = ImagePicker();
  final TextEditingController captionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          "Add Photo",
          style: context.textTheme.bodyRegular
              .copyWith(color: context.darkColor.shade400),
        ),
        const SizedBox(height: 20),
        CustomTextField(
          hintText: "enter caption",
          isObscured: false,
          onChanged: (value) {
            captionTextController.text = value;
          },
        ),
        CustomElevatedButton(
            buttonSize: ButtonSize.large,
            text: "Galeriden Karekod Seç",
            enabled: true,
            isPrimary: false,
            onButtonPressed: (value) async {
              await getImage();
            }),
        const SizedBox(height: 30),
      ],
    );
  }

  Future<void> getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final image = File(pickedImage.path);
      appBloc.createPhoto(image, captionTextController.text);
    }
  }
}
