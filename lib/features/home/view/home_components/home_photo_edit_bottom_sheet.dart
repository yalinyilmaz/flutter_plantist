import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/features/home/model/photo_model.dart';

class PhotoEditBottomSheet extends StatelessWidget {
  const PhotoEditBottomSheet({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 2.5,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomElevatedButton(
              text: "Hide",
              onButtonPressed: (p0) {},
            ),
            CustomElevatedButton(
              text: "Pin",
            ),
            CustomElevatedButton(
              text: "Unfollow",
              onButtonPressed: (p0) {},
              isPrimary: false,
            ),
            CustomElevatedButton(
              text: "Delete",
              onButtonPressed: (p0) {
                appBloc.deletePhoto(photo);
              },
              isPrimary: false,
            ),
          ],
        ),
      ),
    );
  }
}
