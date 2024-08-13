import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';

class TaskHeading extends StatelessWidget {
  const TaskHeading({
    super.key,
    required this.headingText,
    required this.cardColor,
  });

  final String headingText;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: deviceWidth,
      alignment: Alignment.centerLeft,
      child: StyledText.titleMedium(headingText),
    );
  }
}
