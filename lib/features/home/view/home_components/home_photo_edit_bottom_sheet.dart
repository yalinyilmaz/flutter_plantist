import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/app/dialogs/delete_own_photo_dialog.dart';
import 'package:flutter_plantist_app/features/home/model/photo_model.dart';
import 'package:go_router/go_router.dart';

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
              text:  photo.isHided ? "Remove Hide":"Hide",
              onButtonPressed: (p0) {
                photo.isHided = !photo.isHided;
                appBloc.editPhoto(photo);
                context.pop();
              },
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
              onButtonPressed: (p0) async {
                final isApproved = await showDeleteOwnPhotoDialog(context);
                if (isApproved) {
                  appBloc.deletePhoto(photo);
                }
              },
              isPrimary: false,
            ),
          ],
        ),
      ),
    );
  }
}
