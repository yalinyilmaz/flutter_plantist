import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/core/button_animation/animated_fade_button.dart';
import 'package:flutter_plantist_app/features/home/model/photo_model.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/home_photo_card.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/home_photo_edit_bottom_sheet.dart';
import 'package:flutter_plantist_app/features/home/view/home_photo_detail_page.dart';
import 'package:go_router/go_router.dart';

class FeedBody extends StatelessWidget {
  const FeedBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<Photo>>(
        stream: appBloc.photoList,
        builder: (context, snap) {
          switch (snap.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Text("No Photos Found"),
              );
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final photoList = snap.requireData;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: photoList.length,
                    itemBuilder: (context, index) {
                      final photo = photoList.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              showDragHandle: true,
                                              isScrollControlled: true,
                                              isDismissible: true,
                                              builder: (context) {
                                                return PhotoEditBottomSheet(
                                                    photo: photo);
                                              });
                                        },
                                        icon: const Icon(Icons.more_vert))
                                  ],
                                ),
                                Flexible(
                                  child: AnimatedFadeButton(
                                      onTap: () {
                                        context
                                            .push(PhotoDetailsPage.routeName,extra: photo);
                                      },
                                      child: PhotoCard(photo: photo)),
                                ),
                                Text(photo.caption),
                              ],
                            ))),
                      );
                    }),
              );
          }
        });
  }
}
