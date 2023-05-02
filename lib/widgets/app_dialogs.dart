import 'package:fitness_app/core/constants/color_constants.dart';
import 'package:fitness_app/core/constants/text_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static showDialogBox(
          {required BuildContext context,
          String? title,
          String? content,
          VoidCallback? onPressed}) =>
      showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: Text(content!),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed!();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: ColorConstants.errorColor),
              ),
            ),
          ],
        ),
      );

  static showSuccessDialog(
          {required BuildContext context,
          String? title,
          String? content,
          VoidCallback? onPressed}) =>
      showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: Text(content!),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed!();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  static showOpenSettingsDialog(
      {required BuildContext context,
      String? title,
      String? content,
      Function? onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(content!),
        actions: [
          CupertinoDialogAction(
            child: const Text(TextConstants.deny),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: const Text(TextConstants.settingsText),
            onPressed: () {
              onPressed!();
            },
          ),
        ],
      ),
    );
  }
}
