import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/view/helpers/theme.dart';

class CustomTertiaryButton extends StatelessWidget {
  Function? onButtonPressed;
  String mainTitle;
  String? subtitle;
  String? type;
  Widget icon;
  CustomTertiaryButton(
      {super.key,
      required this.mainTitle,
      this.subtitle,
      this.type,
      required this.icon,
      this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        if(onButtonPressed!=null){
          onButtonPressed!.call();
        }
      },
      child: Container(
          constraints: const BoxConstraints(minHeight: 60),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.1),
            border: Border.all(color: context.darkColor.shade100),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mainTitle,
                        style: context.textTheme.bodyRegular
                            .copyWith(fontWeight: FontWeight.w400)),
                    subtitle == null
                        ? const SizedBox.shrink()
                        : Text(subtitle!,
                            style: context.textTheme.calloutRegular
                                .copyWith(color: Colors.grey.shade900))
                  ],
                ),
                Row(
                  children: [
                    Text(
                      type ?? "",
                      style: context.textTheme.bodyEmphasized
                          .copyWith(color: context.darkColor.shade200),
                    ),
                    const SizedBox(width: 5),
                    icon,
                  ],
                )
              ],
            ),
          )),
    );
  }
}
