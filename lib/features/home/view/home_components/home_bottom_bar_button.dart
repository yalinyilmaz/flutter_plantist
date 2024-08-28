import 'package:flutter/cupertino.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:flutter_plantist_app/core/button_animation/animated_fade_button.dart';

// ignore: must_be_immutable
class HomeBottomBarButton extends StatelessWidget {
  HomeBottomBarButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      required this.isActive});

  String title;
  Widget icon;
  Function onTap;
  bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeButton(
      onTap: () {
        onTap.call();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: isActive ? globalCtx.whiteColor.shade500 : null,
            height: 3,
            width: MediaQuery.sizeOf(context).width * .20,
          ),
          icon,
          Text(
            title,
            style: context.textTheme.bodyEmphasized.copyWith(
                color: isActive
                    ? globalCtx.whiteColor.shade500
                    : globalCtx.darkColor.shade500),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
