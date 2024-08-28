import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/navigation/routes.dart';
import 'package:go_router/go_router.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder<T> optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                globalCtx.pop(value);
              } else {
                globalCtx.pop();
              }
            },
            child: Text(
              optionTitle,
            ),
          );
        }).toList(),
      );
    },
  );
}
