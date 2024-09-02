import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/core/extensions/stream_loading_extension.dart';
import 'package:flutter_plantist_app/core/extensions/stream_removing_null_values_ext.dart';
import 'package:flutter_plantist_app/features/authentication/manager/auth_bloc.dart';
import 'package:flutter_plantist_app/features/home/manager/home_pages_manager.dart';
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
  final Sink<Photo> editPhotoCaption;
  final Stream<Iterable<Photo>> photos;
  final Stream<bool> isLoading;
  final Stream<String?> profilePhotoUrl;
  final StreamSubscription<void> _createPhotoSubscription;
  final StreamSubscription<void> _deletePhotoSubscription;
  final StreamSubscription<void> _deleteAllPhotosSubscription;
  final StreamSubscription<void> _editPhotoCaptionSubscription;

  void dispose() {
    userId.close();
    createPhoto.close();
    deletePhoto.close();
    deleteAllPhotos.close();
    editPhotoCaption.close();
    _createPhotoSubscription.cancel();
    _deletePhotoSubscription.cancel();
    _deleteAllPhotosSubscription.cancel();
    _editPhotoCaptionSubscription.cancel();
  }

  const PhotosBloc._({
    required this.userId,
    required this.createPhoto,
    required this.deletePhoto,
    required this.photos,
    required this.deleteAllPhotos,
    required this.editPhotoCaption,
    required this.isLoading,
    required this.profilePhotoUrl,
    required StreamSubscription<void> createPhotoSubscription,
    required StreamSubscription<void> deletePhotoSubscription,
    required StreamSubscription<void> deleteAllPhotosSubscription,
    required StreamSubscription<void> editPhotoCaptionSubscription,
  })  : _createPhotoSubscription = createPhotoSubscription,
        _deletePhotoSubscription = deletePhotoSubscription,
        _deleteAllPhotosSubscription = deleteAllPhotosSubscription,
        _editPhotoCaptionSubscription = editPhotoCaptionSubscription;

  factory PhotosBloc() {
    final backend = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;

    // user id
    final userId = BehaviorSubject<String?>();

    // isLoading
    final isLoading = BehaviorSubject<bool>.seeded(false);

    // upon changes to user id, retrieve our photoList

    final Stream<Iterable<Photo>> photoList = userId.switchMap((userId) {
      if (userId == null) {
        return const Stream<Iterable<Photo>>.empty();
      } else {
        return backend.collection(userId).snapshots().map((snapshots) {
          return snapshots.docs.map((doc) {
            return Photo.fromJson(
              doc.data(),
              null,
              id: doc.id,
            );
          });
        });
      }
    });

    // profile photo
    final Stream<String?> profilePhotoUrl = userId.switchMap((userId) {
      if (userId == null) {
        return Stream.value(null);
      } else {
        return backend.collection(userId).snapshots().map((snapshots) {
          final profilePhotos = snapshots.docs
              .map((doc) => Photo.fromJson(doc.data(), null, id: doc.id))
              .where((photo) => photo.isProfilePhoto);
          return profilePhotos.isNotEmpty ? profilePhotos.first.imageUrl : null;
        });
      }
    });

    // create photo

    final createPhoto = BehaviorSubject<Photo>();

    final StreamSubscription<void> createPhotoSubscription = createPhoto
        .setLoadingTo(true, onSink: isLoading)
        .switchMap((Photo photoToCreate) =>
            userId.take(1).unwrap().asyncMap((userId) async {
              try {
                // Check if this is a profile photo
                if (photoToCreate.isProfilePhoto) {
                  // Find existing profile photo and update it
                  final existingProfilePhoto = await backend
                      .collection(userId)
                      .where('isProfilePhoto', isEqualTo: true)
                      .get();
                  if (existingProfilePhoto.docs.isNotEmpty) {
                    await existingProfilePhoto.docs.first.reference
                        .update({'isProfilePhoto': false});
                  }
                }

                // Upload image to Firebase Storage
                Reference ref = storage.ref().child(
                    'images/${DateTime.now().millisecondsSinceEpoch}.jpg');
                UploadTask uploadTask = ref.putFile(photoToCreate.image!);
                TaskSnapshot taskSnapshot =
                    await uploadTask.whenComplete(() => null);
                String downloadURL = await taskSnapshot.ref.getDownloadURL();
                
                // Update photo data with download URL
                Map<String, dynamic> updatedData = Map.from(photoToCreate.data);
                log(downloadURL);
                updatedData["image"] = downloadURL;

                // Add data to Firestore
                await backend.collection(userId).add(updatedData);

                // go to feed body after photo created
                selectedHomeFragments.value = HomeFragments.feed;
                log("Photo added successfully to Firestore");
              } catch (e) {
                log("Error adding photo to Firestore: $e");
              }
            },),)
        .setLoadingTo(false, onSink: isLoading)
        .listen((event) {});

    // delete photo

    final deletePhoto = BehaviorSubject<Photo>();

    final StreamSubscription<void> deletePhotoSubscription = deletePhoto
        .setLoadingTo(true, onSink: isLoading)
        .switchMap(
          (Photo photoToDelete) => userId.take(1).unwrap().asyncMap(
            (userId) async {
              try {
                // Delete photo from Firestore
                await backend.collection(userId).doc(photoToDelete.id).delete();

                // Delete photo from Firebase Storage
                String imageUrl = photoToDelete.data["image"];
                log(imageUrl);

                Reference ref = storage.refFromURL(imageUrl);
                await ref.delete();
              } catch (e) {
                log("Error deleting photo: $e");
              }
            },
          ),
        )
        .setLoadingTo(false, onSink: isLoading)
        .listen((event) {});

    // delete all photos

    final deleteAllPhotos = BehaviorSubject<void>();

    final StreamSubscription<void> deleteAllContactsSubscription =
        deleteAllPhotos
            .switchMap((_) => userId.take(1).unwrap())
            .asyncMap((userId) => backend.collection(userId).get())
            .switchMap((collection) =>
                Stream.fromFutures(collection.docs.map((doc) async {
                  // Delete photo from Firebase Storage
                  String imageUrl = doc.data()["image"];
                  log(imageUrl);
                  Reference ref = storage.refFromURL(imageUrl);
                  await ref.delete();
                  // Delete photo from Firestore
                  await doc.reference.delete();
                })))
            .listen((_) {});

    // edit photo caption

    final editPhoto = BehaviorSubject<Photo>();

    final StreamSubscription<void> editPhotoSubscription =
        editPhoto
            .switchMap(
              (Photo photoToEdit) => userId.take(1).unwrap().asyncMap(
                (userId) async {
                  try {
                    // Update photo caption in Firestore
                    await backend
                        .collection(userId)
                        .doc(photoToEdit.id)
                        .update({
                      "caption": photoToEdit.caption,
                      "isLiked": photoToEdit.isLiked,
                      "isHided": photoToEdit.isHided,
                      "isProfilePhoto": photoToEdit.isProfilePhoto
                    });

                    log("Photo updated successfully in Firestore");
                  } catch (e) {
                    log("Error updating photo in Firestore: $e");
                  }
                },
              ),
            )
            .listen((event) {});

    // create PhotosBloc
    return PhotosBloc._(
      userId: userId,
      createPhoto: createPhoto,
      deletePhoto: deletePhoto,
      deleteAllPhotos: deleteAllPhotos,
      editPhotoCaption: editPhoto,
      photos: photoList,
      isLoading: isLoading.stream,
      profilePhotoUrl: profilePhotoUrl,
      createPhotoSubscription: createPhotoSubscription,
      deletePhotoSubscription: deletePhotoSubscription,
      deleteAllPhotosSubscription: deleteAllContactsSubscription,
      editPhotoCaptionSubscription: editPhotoSubscription,
    );
  }
}
