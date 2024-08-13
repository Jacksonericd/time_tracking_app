import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/enums/task_type.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/core/presentation/widgets/widget_tap.dart';
import 'package:time_tracking_app/data/model/task.dart';
import 'package:time_tracking_app/presentation/screens/dashboard/widgets/task_heading.dart';

class ScrollableTasks extends StatelessWidget {
  const ScrollableTasks({
    super.key,
    this.tasks,
    required this.taskType,
  });

  final List<Task>? tasks;
  final TaskType taskType;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final cardColor = taskType == TaskType.todo
        ? ColorConstants.todoCard
        : ColorConstants.ongoingCard;
    final dividerColor = taskType == TaskType.todo
        ? ColorConstants.todoCount
        : ColorConstants.ongoingCount;

    Widget dataWidget = noTasksAvailable;

    if ((tasks ?? []).isNotEmpty) {
      dataWidget = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tasks!.length,
          itemBuilder: (context, index) {
            final task = tasks![index];

            return WidgetTap(
                onWidgetTap: () => openBottomSheetForTaskDetails(context, task),
                widget: Container(
                  width: tasks!.length == 1
                      ? deviceWidth * 0.9
                      : deviceWidth * 0.75,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: cardColor,
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
                          WidgetTap(
                              widget: StyledText.labelSmall('Add comment'),
                              onWidgetTap: () => Navigator.of(context)
                                  .pushNamed(RouteConstants.addCommentPath,
                                      arguments: {'task-id': task.id!})),
                          WidgetTap(
                              widget: StyledText.labelSmall(
                                  ' View ${task.commentCount} comments'),
                              onWidgetTap: () => Navigator.of(context)
                                  .pushNamed(RouteConstants.viewTaskCommentPath,
                                      arguments: {'task-id': task.id!})),
                        ],
                      ),
                    ],
                  ),
                ));
          });
    }

    final headingText = taskType == TaskType.ongoing
        ? StringConstants.ongoing
        : StringConstants.todo;

    return SizedBox(
      height: 200,
      width: deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TaskHeading(
            headingText: headingText,
            cardColor: cardColor,
          ),
          Expanded(child: dataWidget),
        ],
      ),
    );
  }
}

Widget get noTasksAvailable => Center(
      child: StyledText.headlineSmall(
        StringConstants.noTasksAvailable,
      ),
    );

openBottomSheetForTaskDetails(BuildContext context, Task task) {
  showModalBottomSheet(
    context: context,
    elevation: 10,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (_) => Container(
      color: Theme.of(context).primaryColorDark.withOpacity(0.6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StyledText.titleMedium('Content : ${task.content}' ),
            const SizedBox(height: 5,),
            StyledText.titleMedium('Description : \n${task.description}' ),
            const SizedBox(height: 5,),
            StyledText.labelSmall('Due date : ${task.due?.datetime}'),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                WidgetTap(
                    widget: StyledText.labelSmall('Add comment'),
                    onWidgetTap: () => Navigator.of(context).pushNamed(
                        RouteConstants.addCommentPath,
                        arguments: {'task-id': task.id!})),
                WidgetTap(
                    widget: StyledText.labelSmall(
                        ' View ${task.commentCount} comments'),
                    onWidgetTap: () => Navigator.of(context).pushNamed(
                        RouteConstants.viewTaskCommentPath,
                        arguments: {'task-id': task.id!})),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
