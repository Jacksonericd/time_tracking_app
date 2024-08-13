import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';

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
              borderRadius: BorderRadius.circular(15.0))),
          backgroundColor:
              WidgetStateProperty.all(ColorConstants.primaryColor)),
      onPressed: onButtonClicked,
      child: StyledText.labelLarge(buttonText),
    );
  }
}
