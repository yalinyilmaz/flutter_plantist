import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/components/terrms_of_use.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:flutter_plantist_app/features/home/manager/home_pages_manager.dart';
import 'package:flutter_plantist_app/features/home/view/home_components/home_bottom_bar_button.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedHomeFragments,
        builder: (context, a, b) {
          return Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.1),
            width: double.infinity,
            decoration: BoxDecoration(color: globalCtx.mainColor.shade400),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HomeBottomBarButton(
                  isActive: selectedHomeFragments.value == HomeFragments.feed,
                  title: "Feed",
                  icon: const Icon(Icons.feed),
                  onTap: () {
                    selectedHomeFragments.value = HomeFragments.feed;
                    // newContainer
                    //     .read(homeManagerProvider)
                    //     .setHomeFragment(HomeFragments.reports);
                  },
                ),
                HomeBottomBarButton(
                  isActive:
                      selectedHomeFragments.value == HomeFragments.createPost,
                  title: "Create Post",
                  icon: const Icon(Icons.post_add),
                  onTap: () {
                    selectedHomeFragments.value = HomeFragments.createPost;
                    // newContainer
                    //     .read(homeManagerProvider)
                    //     .setHomeFragment(HomeFragments.links);
                  },
                ),
                HomeBottomBarButton(
                  isActive:
                      selectedHomeFragments.value == HomeFragments.profile,
                  title: "Profile",
                  icon: const Icon(Icons.person),
                  onTap: () {
                    selectedHomeFragments.value = HomeFragments.profile;
                    // newContainer
                    //     .read(homeManagerProvider)
                    //     .setHomeFragment(HomeFragments.invest);
                  },
                ),
              ],
            ),
          );
        });
  }
}
