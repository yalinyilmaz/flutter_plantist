import 'package:flutter/material.dart';

enum HomeFragments {
  createPost,
  feed,
  profile,
}

// final Map<HomeFragments> selectedHomeFragMap = {

// }

final selectedHomeFragments = ValueNotifier<HomeFragments>(HomeFragments.feed);
