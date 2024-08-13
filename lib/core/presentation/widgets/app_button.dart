import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.buttonText,
    required this.onButtonClicked,
    super.key,
  });

  final String buttonText;
  final VoidCallback onButtonClicked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)))),
      onPressed: onButtonClicked,
      child: Text(buttonText),
    );
  }
}
