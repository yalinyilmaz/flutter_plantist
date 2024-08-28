import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:flutter_plantist_app/features/home/model/photo_model.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/home_bottom_bar.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/home_create_post_body.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/home_feed_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = "/home/_home_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PhotoList"),
          leading: const SizedBox(),
          centerTitle: true,
          backgroundColor: globalCtx.mainColor.shade400,
        ),
        body: const CreatePostBody(),
        bottomNavigationBar: const HomeBottomBar());
  }
}

