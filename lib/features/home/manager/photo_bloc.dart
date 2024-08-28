import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/core/extensions/stream_removing_null_values_ext.dart';
import 'package:flutter_plantist_app/features/home/model/photo_model.dart';
import 'package:rxdart/rxdart.dart';

typedef _Snapshots = QuerySnapshot<Map<String, dynamic>>;
typedef _Document = DocumentReference<Map<String, dynamic>>;


@immutable
class PhotosBloc {
  final Sink<String?> userId;
  final Sink<Photo> createPhoto;
  final Sink<Photo> deletePhoto;
  final Sink<void> deleteAllPhotos;
  final Stream<Iterable<Photo>> photos;
  final StreamSubscription<void> _createPhotoSubscription;
  final StreamSubscription<void> _deletePhotoSubscription;
  final StreamSubscription<void> _deleteAllPhotosSubscription;

  void dispose() {
    userId.close();
    createPhoto.close();
    deletePhoto.close();
    deleteAllPhotos.close();
    _createPhotoSubscription.cancel();
    _deletePhotoSubscription.cancel();
    _deleteAllPhotosSubscription.cancel();
  }

  const PhotosBloc._({
    required this.userId,
    required this.createPhoto,
    required this.deletePhoto,
    required this.photos,
    required this.deleteAllPhotos,
    required StreamSubscription<void> createPhotoSubscription,
    required StreamSubscription<void> deletePhotoSubscription,
    required StreamSubscription<void> deleteAllPhotosSubscription,
  })  : _createPhotoSubscription = createPhotoSubscription,
        _deletePhotoSubscription = deletePhotoSubscription,
        _deleteAllPhotosSubscription = deleteAllPhotosSubscription;

  factory PhotosBloc() {
    final backend = FirebaseFirestore.instance;

    // user id
    final userId = BehaviorSubject<String?>();

    // upon changes to user id, retrieve our photoList

    final Stream<Iterable<Photo>> photoList =
        userId.switchMap<_Snapshots>((userId) {
      if (userId == null) {
        return const Stream<_Snapshots>.empty();
      } else {
        return backend.collection(userId).snapshots();
      }
    }).map<Iterable<Photo>>((snapshots) sync* {
      for (final doc in snapshots.docs) {
        yield Photo.fromJson(
          doc.data(),
          id: doc.id,
        );
      }
    });

    // create photo

    final createPhoto = BehaviorSubject<Photo>();

    final StreamSubscription<void> createPhotoSubscription = createPhoto
        .switchMap(
          (Photo photoToCreate) => userId
              .take(
                1,
              )
              .unwrap()
              .asyncMap(
                (userId) => backend
                    .collection(
                      userId,
                    )
                    .add(
                      photoToCreate.data,
                    ),
              ),
        )
        .listen((event) {});

    // delete photo

    final deletePhoto = BehaviorSubject<Photo>();

    final StreamSubscription<void> deleteContactSubscription = deletePhoto
        .switchMap(
          (Photo photoToDelete) => userId
              .take(
                1,
              )
              .unwrap()
              .asyncMap(
                (userId) => backend
                    .collection(
                      userId,
                    )
                    .doc(
                      photoToDelete.id,
                    )
                    .delete(),
              ),
        )
        .listen((event) {});

    // delete all photos

    final deleteAllPhotos = BehaviorSubject<void>();

    final StreamSubscription<void> deleteAllContactsSubscription =
        deleteAllPhotos
            .switchMap((_) => userId.take(1).unwrap())
            .asyncMap((userId) => backend.collection(userId).get())
            .switchMap((collection) => Stream.fromFutures(
                collection.docs.map((doc) => doc.reference.delete())))
            .listen((_) {});

    // create PhotosBloc
    return PhotosBloc._(
      userId: userId,
      createPhoto: createPhoto,
      deletePhoto: deletePhoto,
      deleteAllPhotos: deleteAllPhotos,
      photos: photoList,
      createPhotoSubscription: createPhotoSubscription,
      deletePhotoSubscription: deleteContactSubscription,
      deleteAllPhotosSubscription: deleteAllContactsSubscription,
    );
  }
}
