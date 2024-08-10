import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    super.key,
    required this.headingText,
    required this.widgetData,
  });

  final String headingText;
  final Widget widgetData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: StyledText.titleLarge(headingText),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: widgetData,
          )
        ],
      ),
    );
  }
}
