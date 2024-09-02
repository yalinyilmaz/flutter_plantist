import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/bodies/home_create_post_body.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/bodies/home_feed_body.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/bodies/home_profile_body.dart';

enum HomeFragments {
  createPost,
  feed,
  profile,
}

final Map<HomeFragments, Widget> selectedHomeFragMap = {
  HomeFragments.createPost: const CreatePostBody(),
  HomeFragments.feed: const FeedBody(),
  HomeFragments.profile: const ProfileBody()
};

final selectedHomeFragments = ValueNotifier<HomeFragments>(HomeFragments.feed);
