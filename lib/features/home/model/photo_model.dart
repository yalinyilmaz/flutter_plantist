import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:uuid/uuid.dart';

@immutable
class Photo {
  final String id;
  final File image;
  final String caption;

  const Photo({
    required this.id,
    required this.image,
    this.caption = "",
  });

  Photo.withoutId({
    required this.image,
    this.caption = "",
  }) : id = const Uuid().v4();

  Photo.fromJson(
    Map<String, dynamic> json, {
    required this.id,
  })  : image = json[_Keys.imageKey] as File,
        caption = json[_Keys.captionKey] as String;

  String get imageView => '$image';

  Map<String, dynamic> get data => {
        _Keys.imageKey: image,
        _Keys.captionKey: caption,
      };
}

@immutable
class _Keys {
  const _Keys._();
  static const imageKey = 'image';
  static const captionKey = 'caption';
}
