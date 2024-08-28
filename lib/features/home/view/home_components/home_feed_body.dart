import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/features/home/model/photo_model.dart';

class FeedBody extends StatelessWidget {
  const FeedBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<Iterable<Photo>>(
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
                  child: ListView.builder(
                      itemCount: photoList.length,
                      itemBuilder: (context, index) {
                        final photo = photoList.elementAt(index);
                        return Image.network(
                          photo.image.path,
                          fit: BoxFit.cover,
                        );
                      }),
                );
            }
          }),
    );
  }
}
