import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:flutter_plantist_app/app/theme/text_theme.dart';
import 'package:flutter_plantist_app/core/button_animation/animated_fade_button.dart';

typedef OnButtonPressed = void Function(BuildContext);

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final OnButtonPressed? onButtonPressed;
  final Color? customColor;
  final bool enabled;
  final VisualDensity visualDensity;
  final double? height;
  final EdgeInsetsGeometry padding;

  final bool isPrimary;
  final ButtonSize buttonSize;

  bool get hasText => text != null;
  bool get hasIcon => icon != null;
  bool get needUseRow => hasIcon && hasText;

  double get buttonHeight => height ?? buttonSize.height;

  bool get isAsyncButton => (onButtonPressed is Future Function(BuildContext));

  // ignore: use_key_in_widget_constructors
  CustomElevatedButton({
    this.text,
    this.icon,
    this.height,
    this.onButtonPressed,
    this.buttonSize = ButtonSize.large,
    this.customColor,
    this.isPrimary = true,
    this.enabled = true,
    this.visualDensity = VisualDensity.standard,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
  });

  Future cbAsAsyncFuture(BuildContext context) =>
      (onButtonPressed as Future Function(BuildContext)).call(context);
  var busy = false;

  handleButtonPressed(BuildContext context) async {
    if (busy) return;
    if (onButtonPressed != null && enabled) {
      if (isAsyncButton) {
        try {
          busy = true;
          await cbAsAsyncFuture(context);
        } finally {
          busy = false;
        }
      } else {
        onButtonPressed!(context);
      }
    }
  }

  BoxDecoration getButtonStyle(BuildContext context) {
    if (!enabled) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: context.mainColor.shade200,
        border: Border.all(color: context.mainColor.shade200),
      );
    }

    if (isPrimary) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            colors: [globalCtx.mainColor.shade500, const Color(0xffAF4EF8)]),
      );
    }

    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: context.mainColor.shade100,
      border: Border.all(color: customColor ?? context.mainColor.shade500),
    );
  }

  TextStyle getButtonTextStyle(BuildContext context) {
    if (!enabled) {
      return buttonHeight > 55
          ? context.textTheme.title2Emphasized
              .copyWith(color: context.whiteColor.shade400)
          : context.textTheme.calloutEmphasized
              .copyWith(color: context.whiteColor.shade400);
    }

    if (isPrimary) {
      return buttonHeight > 55
          ? context.textTheme.title2Emphasized
              .copyWith(color: context.whiteColor.shade50)
          : context.textTheme.calloutEmphasized
              .copyWith(color: context.whiteColor.shade50);
    }

    return buttonHeight > 55
        ? context.textTheme.title2Emphasized
            .copyWith(color: customColor ?? context.mainColor.shade800)
        : context.textTheme.calloutEmphasized
            .copyWith(color: customColor ?? context.mainColor.shade800);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: AnimatedFadeButton(
        onTap: () async {
          await handleButtonPressed(context);
        },
        child: Container(
          height: buttonHeight,
          padding: padding,
          decoration: getButtonStyle(context),
          child: Center(
            child: needUseRow
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon!,
                      const SizedBox(width: 5),
                      Text(text!, style: getButtonTextStyle(context)),
                    ],
                  )
                : hasIcon
                    ? icon
                    : hasText
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0,
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                text!,
                                style: getButtonTextStyle(context),
                              ),
                            ),
                          )
                        : const SizedBox(),
          ),
        ),
      ),
    );
  }
}

enum ButtonSize {
  large,
  medium,
  small;

  double get height {
    switch (this) {
      case ButtonSize.large:
        return 60;
      case ButtonSize.medium:
        return 55;
      case ButtonSize.small:
        return 45;
    }
  }
}
