import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:flutter_plantist_app/features/home/manager/home_pages_manager.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/home_bottom_bar.dart';


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
        body: ValueListenableBuilder(
          valueListenable: selectedHomeFragments,
          builder: (context,w,_) {
            return selectedHomeFragMap[selectedHomeFragments.value]!;
          }
        ),
        bottomNavigationBar: const HomeBottomBar());
  }
}

