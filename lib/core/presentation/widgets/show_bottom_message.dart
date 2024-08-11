import 'package:flutter/material.dart';

showBottomMessage(
  BuildContext context, {
  required String message,
  bool success = false,
}) {
  final deviceWidth = MediaQuery.of(context).size.width;

  showModalBottomSheet(
    context: context,
    elevation: 10,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    isDismissible: false,
    builder: (_) => Container(
      color: Theme.of(context).primaryColorDark.withOpacity(0.6),
      child: Container(
        width: deviceWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(34.0),
            topRight: Radius.circular(34.0),
          ),
        ),
        child: Container(
          color: success
              ? Theme.of(context).highlightColor
              : Theme.of(context).colorScheme.error,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    width: deviceWidth * 0.8,
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).primaryColorLight),
                    )),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(success ? "1" : "0"),
                child: Icon(Icons.close,
                    color: Theme.of(context).primaryColorLight),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
