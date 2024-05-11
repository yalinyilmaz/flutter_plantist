import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/view/helpers/theme.dart';
import 'package:go_router/go_router.dart';

class BottomSheetHeader extends StatelessWidget {
  String title;
  BottomSheetHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              "Cancel",
              style: context.textTheme.bodyEmphasized
                  .copyWith(color: Colors.blueAccent),
            )),
        Text(title,
            style: context.textTheme.bodyEmphasized
                .copyWith(fontWeight: FontWeight.w600)),
        TextButton(
            onPressed: () {},
            child: Text(
              "Add",
              style: context.textTheme.bodyEmphasized
                  .copyWith(fontWeight: FontWeight.w600),
            )),
      ],
    );
  }
}
