import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:uuid/uuid.dart';

@immutable
// ignore: must_be_immutable
class Photo {
  final String id;
  final File? image;
  final String? imageUrl;
  String caption;
  bool isLiked;
  bool isHided;

  Photo({
    this.imageUrl,
    required this.id,
    this.image,
    this.caption = "",
    this.isLiked = false,
    this.isHided = false,
  });

  Photo.withoutId({
    this.imageUrl,
    this.image,
    this.caption = "",
    this.isLiked = false,
    this.isHided = false,
  }) : id = const Uuid().v4();

  Photo.fromJson(
    Map<String, dynamic> json, this.image, {
    required this.id,
  })  : imageUrl = json[_Keys.imageKey] as String,
        caption = json[_Keys.captionKey] as String,
        isLiked = json[_Keys.isLikedKey] as bool,
        isHided = json[_Keys.isHidedKey] as bool;

  String get imageView => '$image';

  Map<String, dynamic> get data => {
        _Keys.imageKey: imageUrl,
        _Keys.captionKey: caption,
        _Keys.isLikedKey: isLiked,
        _Keys.isHidedKey: isHided,
      };
}

@immutable
class _Keys {
  const _Keys._();
  static const imageKey = 'image';
  static const captionKey = 'caption';
  static const isLikedKey = 'isLiked';
  static const isHidedKey = 'isHided';
}
