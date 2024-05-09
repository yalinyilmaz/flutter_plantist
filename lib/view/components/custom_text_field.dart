import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/view/helpers/theme.dart';

class CustomTextField extends StatefulWidget {
  final Widget? suffixIcon;
  final bool isObscured;
  final String? initialValue;
  final Function? validator;
  final Function? onChanged;
  final Function? onSubmit;
  final String hintText;
  CustomTextField(
      {super.key,
      this.initialValue,
      this.validator,
      this.onChanged,
      this.onSubmit,
      required this.hintText,
      required this.isObscured,
      this.suffixIcon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

bool showing = true;

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: context.darkColor.shade900,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.darkColor.shade100)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.darkColor.shade100)),
          hintText: widget.hintText,
          hintStyle: context.textTheme.calloutEmphasized.copyWith(
              color: context.darkColor.shade200, fontWeight: FontWeight.w600),
          suffixIconConstraints:
              const BoxConstraints(minHeight: 44, minWidth: 44),
          suffixIcon: _suffixIconBuilder()),
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
      },
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!.call();
        }
      },
      onFieldSubmitted: (value) {
        if (widget.onSubmit != null) {
          widget.onSubmit!.call();
        }
      },
      obscureText: widget.isObscured && showing,
      obscuringCharacter: "*",
    );
  }

  Widget? _suffixIconBuilder() {
    return GestureDetector(
        onTap: () {
          showing = !showing;
          setState(() {});
        },
        child: SizedBox(
            child:
                showing ? widget.suffixIcon : const Icon(CupertinoIcons.eye)));
  }
}
