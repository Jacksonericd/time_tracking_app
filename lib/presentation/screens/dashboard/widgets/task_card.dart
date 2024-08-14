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
    required this.width,
    required this.cardColor,
    required this.dividerColor,
    required this.task,
    required this.onAddCommentTap,
    required this.onViewCommentTap,
  });

  final double width;
  final Color cardColor;
  final Color dividerColor;
  final Task task;
  final VoidCallback onAddCommentTap;
  final VoidCallback onViewCommentTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: cardColor,
        boxShadow: const [
          BoxShadow(
            color: ColorConstants.greyColorC3,
            spreadRadius: 0.5,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText.titleMedium(task.content!),
          // if (task.due?.date != null) ...{
          StyledText.labelSmall('Due date : ${task.due?.datetime}'),
          // },
          Divider(
            color: dividerColor,
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LinkText(
                linkDisplayText: StringConstants.addComment,
                onTap: onAddCommentTap,
              ),
              LinkText(
                linkDisplayText: 'View ${task.commentCount} comments',
                onTap: onViewCommentTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
