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
          // title: Text(title!),
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
              child: const Text('No'),
            ),
          ],
        ),
      );
}
