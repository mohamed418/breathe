import 'package:flutter/material.dart';

class DialogUtils {
  static void showProgressDialog(BuildContext context, String message,
      {bool isDismissible = true}) {
    showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                width: 12,
              ),
              Text(message),
            ],
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  static void showMessage(BuildContext context, String message,
      {String? positiveActionTitle,
      Function? positiveAction,
      String? negativeActionTitle,
      Function? negativeAction,
      bool isDismissible = true}) {
    showDialog(
      context: context,
      builder: (buildContext) {
        List<Widget> actions = [];
        if (positiveActionTitle != null) {
          actions.add(TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (positiveAction != null) positiveAction();
              },
              child: Text(positiveActionTitle)));
        }
        if (negativeActionTitle != null) {
          actions.add(TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (negativeAction != null) negativeAction();
              },
              child: Text(negativeActionTitle)));
        }
        return AlertDialog(
          content: Text(message),
          actions: actions,
        );
      },
      barrierDismissible: isDismissible,
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
