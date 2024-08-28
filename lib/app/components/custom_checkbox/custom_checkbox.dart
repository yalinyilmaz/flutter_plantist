import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';


// ignore: must_be_immutable
class NewCustomSelectCheckbox extends StatefulWidget {
  NewCustomSelectCheckbox({super.key, this.onTap, this.isChecked = false});
  bool isChecked;
  Function? onTap;

  @override
  State<NewCustomSelectCheckbox> createState() =>
      _NewCustomSelectCheckboxState();
}

class _NewCustomSelectCheckboxState extends State<NewCustomSelectCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap!.call();
      },
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: context.mainColor.shade200,
          border: Border.all(color: context.mainColor.shade500, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: widget.isChecked
            ? Icon(
                Icons.check,
                color: context.mainColor.shade500,
                size: 18,
                weight: 25,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
