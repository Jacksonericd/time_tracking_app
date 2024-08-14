import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:time_tracking_app/core/config/navigator_key.dart';

Future<void> showPopUp(
    {required String title,
    required String subTitle,
    required String leftButtonText,
    required String rightButtonText,
    required Function? onPressLeft,
    required Function? onPressRight}) async {
  var ctx = appNavigatorKey.currentContext!;

  showCupertinoModalPopup<void>(
    context: ctx,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => onPressLeft!(),
          child: Text(leftButtonText),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => onPressRight!(),
          child: Text(rightButtonText),
        ),
      ],
    ),
  );
}
