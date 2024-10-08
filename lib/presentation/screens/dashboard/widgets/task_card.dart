import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/core/presentation/widgets/widget_tap.dart';
import 'package:time_tracking_app/data/model/task.dart';

import 'link_text.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.dividerColor,
    required this.task,
    required this.onAddCommentTap,
    required this.onViewCommentTap,
  });

  final Color dividerColor;
  final Task task;
  final VoidCallback onAddCommentTap;
  final VoidCallback onViewCommentTap;

  static const priorityMap = {
    1: 'Low',
    2: 'Normal',
    3: 'High',
    4: 'Critical',
  };

  Widget get vSPacingFive => const SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).primaryColorLight,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          vSPacingFive,
          Text(task.content!, style:  Theme.of(context).textTheme.titleMedium),
          vSPacingFive,
          StyledText.labelSmall('Priority : ${priorityMap[task.priority]}'),
          Divider(
            color: dividerColor,
            height: 1,
          ),
          vSPacingFive,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LinkText(
                linkDisplayText: StringConstants.addComment,
                onTap: onAddCommentTap,
              ),
              if ((task.commentCount ?? 0) > 0) ...{
                LinkText(
                  linkDisplayText: 'View ${task.commentCount} comments',
                  onTap: onViewCommentTap,
                ),
              },
            ],
          ),
          vSPacingFive,
        ],
      ),
    );
  }
}
