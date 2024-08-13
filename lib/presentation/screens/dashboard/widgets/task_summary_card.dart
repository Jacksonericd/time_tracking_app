import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key,
    required this.headingText,
    required this.valueText,
  });

  final String headingText;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).cardColor),
      child: Column(
        children: [
          Container(
            height: 30,
            alignment: Alignment.center,
            child: StyledText.titleSmall(headingText),
            // child: Text(
            //   headingText,
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Theme.of(context).primaryColorLight,
            //   ),
            // ),
          ),
          const SizedBox(height: 5,),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColorLight,
            radius: deviceWidth * 0.060,
            child: StyledText.titleLarge(valueText),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
