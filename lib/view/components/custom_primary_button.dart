import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/view/helpers/theme.dart';

typedef OnButtonPressed = void Function(BuildContext);

// ignore: must_be_immutable
class CustomPrimaryButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final OnButtonPressed? onButtonPressed;
  final Color? customColor;
  final bool enabled;
  final VisualDensity visualDensity;
  final double height;
  final EdgeInsetsGeometry padding;

  bool get hasText => text != null;
  bool get hasIcon => icon != null;
  bool get needUseRow => hasIcon && hasText;

  bool get isAsyncButton => (onButtonPressed is Future Function(BuildContext));

  // ignore: use_key_in_widget_constructors
  CustomPrimaryButton(
      {this.text,
      this.icon,
      this.onButtonPressed,
      this.customColor,
      this.enabled = true,
      this.visualDensity = VisualDensity.standard,
      this.height = 50,
      this.padding = const EdgeInsets.symmetric(horizontal: 12)});

  Future cbAsAsyncFuture(context) =>
      (onButtonPressed as Future Function(BuildContext)).call(context);
  var busy = false;

  handleButtonPressed(context) async {
    if (onButtonPressed != null && enabled) {
      onButtonPressed!(context);
    }
  }

  BoxDecoration getButtonStyle(BuildContext context) {
    if (!enabled) {
      return BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black.withOpacity(0.3),
          border: Border.all(color: Colors.black.withOpacity(0.3)));
    } else {
      return BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: customColor ?? context.darkColor.shade900,
          border: Border.all(color: customColor ?? context.darkColor.shade900));
    }
  }

  TextStyle getButtonTextStyle(BuildContext context) {
    if (!enabled) {
      return context.textTheme.title3Emphasized
          .copyWith(color: context.whiteColor.shade100);
    } else {
      return context.textTheme.title3Emphasized
          .copyWith(color: context.whiteColor.shade50);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: GestureDetector(
        onTap: () async {
          await handleButtonPressed(context);
        },
        child: Container(
            height: height,
            padding: padding,
            decoration: getButtonStyle(context),
            child: Center(
                child: needUseRow
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          icon!,
                          const SizedBox(width: 5),
                          Text(
                            text!,
                            style: getButtonTextStyle(context),
                          ),
                        ],
                      )
                    : hasIcon
                        ? icon
                        : hasText
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    text!,
                                    style: getButtonTextStyle(context),
                                  ),
                                ),
                              )
                            : const SizedBox())),
      ),
    );
  }
}
