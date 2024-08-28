import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/dialogs/generic_message_dialogs.dart';
import 'package:flutter_plantist_app/features/authentication/model/auth_error_model.dart';

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) =>
    showGenericDialog(
      context: context,
      title: authError.dialogTitle,
      content: authError.dialogText,
      optionsBuilder: () => {
        'OK': true,
      },
    );
