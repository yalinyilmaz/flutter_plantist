import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_plantist_app/app/dialogs/generic_message_dialogs.dart';

Future<bool> showDeleteOwnPhotoDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete Photo',
    content:
        'Are you sure you want to delete this photo? You cannot undo this operation!',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
