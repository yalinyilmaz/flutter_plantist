import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/view/helpers/theme.dart';

class MessageDialog {
  MessageDialog(
      {required this.context,
      required this.content,
      required this.height,
      });
  BuildContext context;
  double height;
  Widget content;

  Future<void> withSingleButton() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: const EdgeInsets.all(12),
              insetPadding: const EdgeInsets.all(8),
              content: Container(
                height: height,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.grey,
                ),
                child: content,
              ),
            ));
  }
}
