import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/enums/task_type.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key,
    required this.headingText,
    required this.valueText,
    required this.taskType,
  });

  final String headingText;
  final String valueText;
  final TaskType taskType;

  @override
  Widget build(BuildContext context) {
    final valueColorMap = {
      TaskType.todo: ColorConstants.todoCount,
      TaskType.ongoing: ColorConstants.ongoingCount,
      TaskType.completed: ColorConstants.completedCount,
    };

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            valueText,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: valueColorMap[taskType]),
          ),
          StyledText.titleSmall(headingText),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
