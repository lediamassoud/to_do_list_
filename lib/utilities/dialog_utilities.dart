import 'package:flutter/material.dart';
import 'package:to_do_list/extention_function/extention_function_l10n.dart';

import 'app_theme.dart';

abstract class DialogUtilities {
  static void showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                Text(context.l10n.loading),
                const Spacer(),
                const CircularProgressIndicator()
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showError(BuildContext context, [String? message]) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text(
              context.l10n.error,
              style: TextStyle(color: AppTheme.redColor),
            ),
            content: Text(message ?? context.l10n.error_message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(context.l10n.ok))
            ],
          );
        });
  }
}
