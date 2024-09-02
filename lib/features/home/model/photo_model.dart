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

  Photo({
    this.imageUrl,
    required this.id,
    this.image,
    this.caption = "",
  });

  Photo.withoutId({
    this.imageUrl,
    this.image,
    this.caption = "",
  }) : id = const Uuid().v4();

  Photo.fromJson(
    Map<String, dynamic> json, this.image, {
    required this.id,
  })  : imageUrl = json[_Keys.imageKey] as String,
        caption = json[_Keys.captionKey] as String;

  String get imageView => '$image';

  Map<String, dynamic> get data => {
        _Keys.imageKey: imageUrl,
        _Keys.captionKey: caption,
      };
}

@immutable
class _Keys {
  const _Keys._();
  static const imageKey = 'image';
  static const captionKey = 'caption';
}
