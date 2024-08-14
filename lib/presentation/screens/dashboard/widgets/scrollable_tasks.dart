import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/enums/task_type.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/presentation/widgets/menu_button.dart';
import 'package:time_tracking_app/core/presentation/widgets/show_bottom_message.dart';
import 'package:time_tracking_app/core/presentation/widgets/show_popup.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/core/presentation/widgets/widget_tap.dart';
import 'package:time_tracking_app/data/model/task.dart';
import 'package:time_tracking_app/data/model/task_start_time.dart';
import 'package:time_tracking_app/domain/usecases/local_data_usecase.dart';
import 'package:time_tracking_app/domain/usecases/task_usecase.dart';
import 'package:time_tracking_app/presentation/screens/comments/view/add_edit_comment.dart';
import 'package:time_tracking_app/presentation/screens/dashboard/widgets/link_text.dart';
import 'package:time_tracking_app/presentation/screens/dashboard/widgets/task_card.dart';
import 'package:time_tracking_app/presentation/screens/dashboard/widgets/task_heading.dart';

class ScrollableTasks extends StatelessWidget {
  const ScrollableTasks({
    super.key,
    this.tasks,
    required this.taskType,
    required this.refreshBloc,
  });

  final List<Task>? tasks;
  final TaskType taskType;
  final VoidCallback refreshBloc;

  // final Function(String taskId) onBeginTask;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final cardColor = Theme.of(context).primaryColorLight;
    final dividerColor = Theme.of(context).primaryColorDark.withOpacity(0.10);

    // final cardColor = taskType == TaskType.todo
    //     ? ColorConstants.todoCard
    //     : ColorConstants.ongoingCard;
    // final dividerColor = taskType == TaskType.todo
    //     ? ColorConstants.todoCount
    //     : ColorConstants.ongoingCount;

    Widget dataWidget = noTasksAvailable;

    final isTaskEmpty = (tasks ?? []).isNotEmpty;

    if (isTaskEmpty) {
      if (tasks?.length == 1) {
        final task = tasks?.firstOrNull;
        dataWidget = WidgetTap(
            onWidgetTap: () => openBottomSheetForTaskDetails(context, task),
            widget: TaskCard(
              width: deviceWidth,
              cardColor: cardColor,
              dividerColor: dividerColor,
              task: task!,
              onAddCommentTap: () => Navigator.of(context).pushNamed(
                  RouteConstants.addCommentPath,
                  arguments: {'task-id': task.id!}),
              onViewCommentTap: () => Navigator.of(context).pushNamed(
                  RouteConstants.viewTaskCommentPath,
                  arguments: {'task-id': task.id!}),
            ));
      } else {
        dataWidget = ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tasks!.length,
            itemBuilder: (context, index) {
              final task = tasks![index];

              return WidgetTap(
                  onWidgetTap: () =>
                      openBottomSheetForTaskDetails(context, task),
                  widget: TaskCard(
                    width: deviceWidth * 0.75,
                    cardColor: cardColor,
                    dividerColor: dividerColor,
                    task: task,
                    onAddCommentTap: () => _addCommentPopup(context, task.id!),
                    onViewCommentTap: () => Navigator.of(context).pushNamed(
                        RouteConstants.viewTaskCommentPath,
                        arguments: {'task-id': task.id!}),
                  ));
            });
      }
    }

    final mapTaskNames = {
      TaskType.todo: StringConstants.todo,
      TaskType.ongoing: StringConstants.ongoing,
      TaskType.completed: StringConstants.completed,
    };

    return SizedBox(
      height: 200,
      width: deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TaskHeading(
            headingText: mapTaskNames[taskType] ?? StringConstants.empty,
            cardColor: cardColor,
          ),
          Expanded(child: dataWidget),
        ],
      ),
    );
  }

  Widget get noTasksAvailable => Center(
        child: StyledText.headlineSmall(
          StringConstants.noTasksAvailable,
        ),
      );

  Widget get vSpacingFive => const SizedBox(
        height: 5,
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
            children: [
              Container(
                height: 5,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorConstants.greyColorC3),
              ),
              vSpacingFive,
              vSpacingFive,
              StyledText.headlineSmall(StringConstants.taskDetails),
              vSpacingFive,
              vSpacingFive,
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StyledText.titleMedium('${task.content}'),
                  vSpacingFive,
                  StyledText.titleMedium('Description : ${task.description}'),
                  vSpacingFive,
                  StyledText.labelSmall(task.due?.datetime == null
                      ? StringConstants.empty
                      : 'Due date : ${task.due?.datetime}'),
                  vSpacingFive,
                  vSpacingFive,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      LinkText(
                        linkDisplayText: StringConstants.addComment,
                        color: ColorConstants.errorRed,
                        onTap: () => _addCommentPopup(context, task.id!),
                        // onTap: () => Navigator.of(context).pushNamed(
                        //     RouteConstants.addCommentPath,
                        //     arguments: {'task-id': task.id!}),
                      ),
                      if ((task.commentCount ?? 0) > 0) ...{
                        LinkText(
                          linkDisplayText: 'View ${task.commentCount} comments',
                          color: ColorConstants.errorRed,
                          onTap: () => Navigator.of(context).pushNamed(
                              RouteConstants.viewTaskCommentPath,
                              arguments: {'task-id': task.id!}),
                        ),
                      },
                    ],
                  ),
                  vSpacingFive,
                  vSpacingFive,
                  if (taskType == TaskType.todo) ...{
                    MenuButton(
                      onMenuTapped: () async =>
                          await _beginTaskPopup(context, task.id!),
                      menuText: StringConstants.beginTask,
                    ),
                    vSpacingFive,
                  },
                  if (taskType == TaskType.ongoing) ...{
                    MenuButton(
                      onMenuTapped: () async {
                        await _completeTask(context, task.id!);
                      },
                      menuText: StringConstants.completeTask,
                    ),
                    vSpacingFive,
                  },
                  MenuButton(
                    onMenuTapped: () => Navigator.of(context).pushNamed(
                      RouteConstants.editTaskPath,
                      arguments: {
                        'task-id': task.id,
                      },
                    ),
                    menuText: StringConstants.editTask,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _beginTaskPopup(
    BuildContext context,
    String taskId,
  ) async {
    await showPopUp(
        title: StringConstants.popupTitle,
        subTitle: StringConstants.popupSubTitle,
        leftButtonText: StringConstants.cancel,
        rightButtonText: StringConstants.confirm,
        onPressLeft: Navigator.of(context).pop,
        onPressRight: () async {
          if (context.mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            try {
              await Injector.resolve<LocalDataUseCase>().insertTaskTime(
                taskId: taskId,
                startTime: DateTime.now().toString(),
              );

              refreshBloc();
            } catch (e) {
              if (context.mounted) {
                showBottomMessage(context, message: '$e');
              }
            }
          }
        });
  }

  Future<void> _completeTask(BuildContext context, String taskId) async {
    await showPopUp(
        title: StringConstants.popupTitle,
        subTitle: StringConstants.popupSubTitle,
        leftButtonText: StringConstants.cancel,
        rightButtonText: StringConstants.confirm,
        onPressLeft: Navigator.of(context).pop,
        onPressRight: () async {
          if (context.mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            try {
              final localResponse = await Injector.resolve<LocalDataUseCase>()
                  .getTaskTimerById(taskId);

              print('startTime $localResponse');

              final ongoingTasks = (localResponse as List)
                  .map((task) => TasksStartTime.fromJson(task))
                  .toList();

              final startTime = DateTime.parse(ongoingTasks.last.startTime!);

              print('startTime $startTime');

              final durationInMinutes =
                  DateTime.now().difference(startTime).inMinutes;

              print('durationInMinutes $durationInMinutes');

              final durationMap = {
                'duration': durationInMinutes,
                'duration_unit': 'minute'
              };

              await Injector.resolve<TaskUseCase>().updateTask(
                taskId: taskId,
                inputData: durationMap,
              );

              print('Task updated ');

              await Injector.resolve<LocalDataUseCase>().updateTaskEndTime(
                taskId: taskId,
                endTime: DateTime.now().toString(),
              );

              print('Task completed');

              if (context.mounted) {
                refreshBloc();
              }
            } catch (e) {
              if (context.mounted) {
                showBottomMessage(context, message: '$e');
              }
            }
          }
        });
  }

  Future<void> _addCommentPopup(
    BuildContext context,
    String taskId,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title:
            Center(child: StyledText.headlineSmall(StringConstants.addComment)),
        content: AddEditComment(
          taskId: taskId,
        ),
      ),
    );
  }
}
