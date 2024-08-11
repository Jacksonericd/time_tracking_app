import 'dart:async';
import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({super.key});

  static void hide(BuildContext context) => Navigator.pop(context);

  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  @override
  State<StatefulWidget> createState() => LoadingDialogState();
}

class LoadingDialogState extends State<LoadingDialog> {
  Timer? timer;
  int currTimer = 0;

  startTimer() {
    timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer t) => setState(() {
              currTimer = t.tick;
            }));
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return PopScope(
        canPop: false,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).disabledColor,
            ),
            child: Container(
              width: deviceWidth * 0.5,
              height: 50,
              alignment: Alignment.center,
              color: Theme.of(context).disabledColor,
              child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                        height: 15,
                        width: 15,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary)),
                        child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (currTimer % 4) == index
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).primaryColorLight,
                            )));
                  }),
            ),
          ),
        ));
  }
}
