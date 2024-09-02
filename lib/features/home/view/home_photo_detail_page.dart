import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:flutter_plantist_app/features/home/model/photo_model.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/home_photo_card.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/home_photo_edit_bottom_sheet.dart';

class PhotoDetailsPage extends StatefulWidget {
  const PhotoDetailsPage({super.key, required this.photo});
  static const routeName = "/home/photo_detail_page";

  final Photo photo;

  @override
  State<PhotoDetailsPage> createState() => _PhotoDetailsPageState();
}

class _PhotoDetailsPageState extends State<PhotoDetailsPage> {
  late TextEditingController captionTextController;
  late final ValueNotifier<bool> isLiked;

  @override
  void initState() {
    captionTextController = TextEditingController(text: widget.photo.caption);
    isLiked = ValueNotifier<bool>(widget.photo.isLiked);
    super.initState();
  }

  @override
  void dispose() {
    appBloc.editPhoto(widget.photo);
    log("photo edited");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
        backgroundColor: globalCtx.mainColor.shade400,
      ),
      body: SingleChildScrollView(
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
                            return PhotoEditBottomSheet(photo: widget.photo);
                          });
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
            GestureDetector(
              onDoubleTap: () {
                isLiked.value = !isLiked.value;
                widget.photo.isLiked = isLiked.value;
              },
              child: PhotoCard(photo: widget.photo),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: captionTextController,
                onChanged: (value) {
                  widget.photo.caption = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Edit caption',
                  border: InputBorder.none,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder(
                  valueListenable: isLiked,
                  builder: (context, a, _) {
                    return IconButton(
                      icon: Icon(
                        isLiked.value ? Icons.favorite : Icons.favorite_border,
                        size: 50,
                        color: isLiked.value ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        isLiked.value = !isLiked.value;
                        widget.photo.isLiked = isLiked.value;
                        log("Photo liked or like removed");
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
