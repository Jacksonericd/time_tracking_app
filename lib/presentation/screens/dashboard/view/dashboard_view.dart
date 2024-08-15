import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:time_tracking_app/core/config/navigator_key.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/image_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/enums/task_type.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/asset_image.dart';
import 'package:time_tracking_app/core/presentation/widgets/bloc_state_widget.dart';
import 'package:time_tracking_app/core/presentation/widgets/menu_button.dart';
import 'package:time_tracking_app/core/presentation/widgets/show_bottom_message.dart';
import 'package:time_tracking_app/core/presentation/widgets/show_popup.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/core/presentation/widgets/widget_tap.dart';
import 'package:time_tracking_app/data/model/board_model.dart';
import 'package:time_tracking_app/data/model/task.dart';
import 'package:time_tracking_app/data/model/task_start_time.dart';
import 'package:time_tracking_app/domain/usecases/comment_usecase.dart';
import 'package:time_tracking_app/domain/usecases/local_data_usecase.dart';
import 'package:time_tracking_app/domain/usecases/task_usecase.dart';
import 'package:time_tracking_app/presentation/bloc/task/task_bloc.dart';
import 'package:time_tracking_app/presentation/screens/comments/view/add_edit_comment.dart';
import 'package:time_tracking_app/presentation/screens/comments/view/view_comments.dart';
import 'package:time_tracking_app/presentation/screens/dashboard/widgets/task_card.dart';

import '../widgets/link_text.dart';
import '../widgets/task_summary_card.dart';
import '../widgets/timer_clock.dart';

//ignore: must_be_immutable
class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  static const projectId = String.fromEnvironment('project_id');

  List<BoardListModel> _listData = [];

  Widget get topSpacing => const SizedBox(
        height: 50.0,
      );

  Widget get appLogo => ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: const AssetImageWidget(
          assetPath: ImageConstants.appIconPng,
          boxFit: BoxFit.cover,
          height: 70,
          width: 70,
        ),
      );

  Widget get introWidget =>
      StyledText.displaySmall(StringConstants.welcomeComma);

  Widget get introSummaryWidget => Align(
      alignment: Alignment.centerLeft,
      child: StyledText.labelLarge(StringConstants.welcomeSummary));

  @override
  Widget build(BuildContext context) {
    refreshBloc(context);

    return AppScaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(RouteConstants.addTaskPath),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      scaffoldBody: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return BlocStateToWidget(
            message: state.message ?? '',
            blocStates: state.blocStates,
            child: displayBoardData(
              state,
              context,
            ),
          );
        },
      ),
    );
  }

  void refreshBloc(BuildContext context) {
    BlocProvider.of<TaskBloc>(context)
        .add(GetTasksByProjectEvent(projectId: projectId));
  }

  Widget displayBoardData(TaskState state, BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final todoTasks = state.taskTodoList;
    final ongoingTasks = state.taskOngoingList;
    final completedTasks = state.taskCompList;

    final topContent = [
      topSpacing,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          introWidget,
          appLogo,
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      introSummaryWidget,
      const SizedBox(
        height: 5,
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        width: deviceWidth,
        alignment: Alignment.centerLeft,
        child: StyledText.titleLarge(StringConstants.taskSummary),
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        children: [
          Expanded(
              flex: 1,
              child: TaskSummaryCard(
                headingText: StringConstants.todo,
                valueText: '${todoTasks?.length}',
                taskType: TaskType.todo,
              )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              flex: 1,
              child: TaskSummaryCard(
                headingText: StringConstants.ongoing,
                valueText: '${ongoingTasks?.length}',
                taskType: TaskType.ongoing,
              )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              flex: 1,
              child: TaskSummaryCard(
                headingText: StringConstants.completed,
                valueText: '${completedTasks?.length}',
                taskType: TaskType.completed,
              )),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ];

    BoardViewController boardViewController = BoardViewController();

    _listData = [
      BoardListModel(
          name: StringConstants.todo,
          items: todoTasks ?? [],
          taskType: TaskType.todo),
      BoardListModel(
          name: StringConstants.ongoing,
          items: ongoingTasks ?? [],
          taskType: TaskType.ongoing),
      BoardListModel(
          name: StringConstants.completed,
          items: completedTasks ?? [],
          taskType: TaskType.completed),
    ];

    List<BoardList> lists = [];

    for (int i = 0; i < _listData.length; i++) {
      lists.add(_createBoardList(_listData[i]) as BoardList);
    }

    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: topContent,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              child: Container(
                  color: Theme.of(context).primaryColorLight,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 24,
                  ),
                  child: BoardView(
                    lists: lists,
                    boardViewController: boardViewController,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoardItem(
    Task task,
    TaskType taskType,
  ) {
    return BoardItem(
        draggable: true,
        onStartDragItem:
            (int? listIndex, int? itemIndex, BoardItemState? state) {},
        onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
            int? oldItemIndex, BoardItemState? state) {
          var item = _listData[oldListIndex!].items[oldItemIndex!];
          _listData[oldListIndex].items.removeAt(oldItemIndex);
          _listData[listIndex!].items.insert(itemIndex!, item);

          final fromTaskType = _listData[oldListIndex].taskType;
          final toTaskType = _listData[listIndex].taskType;

          _manageDropTask(item.id!, fromTaskType, toTaskType);
        },
        onTapItem:
            (int? listIndex, int? itemIndex, BoardItemState? state) async {},
        item: WidgetTap(
          onWidgetTap: () => openBottomSheetForTaskDetails(task, taskType),
          widget: TaskCard(
            width: 100,
            cardColor: ColorConstants.colorWhite,
            dividerColor: ColorConstants.colorWhite.withOpacity(0.10),
            task: task,
            onAddCommentTap: () => _addCommentPopup(taskId: task.id!),
            onViewCommentTap: () => _openBottomSheetForViewComments(
              taskId: task.id!,
            ),
          ),
        ));
  }

  void _handleDropList(int? listIndex, int? oldListIndex) {
    var list = _listData[oldListIndex!];
    _listData.removeAt(oldListIndex);
    _listData.insert(listIndex!, list);
  }

  Widget _createBoardList(BoardListModel list) {
    List<BoardItem> items = [];
    for (int i = 0; i < list.items.length; i++) {
      items.insert(
          i, buildBoardItem(list.items[i], list.taskType) as BoardItem);
    }

    return BoardList(
      draggable: true,
      headerBackgroundColor:
          Theme.of(appNavigatorKey.currentContext!).cardColor,
      onDropList: _handleDropList,
      header: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: StyledText.bodyLarge(list.name),
        )
      ],
      items: items,
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

  openBottomSheetForTaskDetails(
    Task task,
    TaskType taskType,
  ) {
    final context = appNavigatorKey.currentContext!;
    final deviceHeight = MediaQuery.of(context).size.height;

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
          child: SingleChildScrollView(
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
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyledText.titleMedium('${task.content}'),
                      vSpacingFive,
                      StyledText.titleMedium(
                          'Description : ${task.description}'),
                      vSpacingFive,
                      if (taskType == TaskType.ongoing) ...{
                        Center(
                            child: TimerClock(
                          taskId: task.id!,
                        )),
                      },
                      vSpacingFive,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          LinkText(
                            linkDisplayText: StringConstants.addComment,
                            color: ColorConstants.errorRed,
                            onTap: () => _addCommentPopup(
                              ctx: context,
                              taskId: task.id!,
                            ),
                          ),
                          if ((task.commentCount ?? 0) > 0) ...{
                            LinkText(
                              linkDisplayText:
                                  'View ${task.commentCount} comments',
                              color: ColorConstants.errorRed,
                              onTap: () => _openBottomSheetForViewComments(
                                ctx: context,
                                taskId: task.id!,
                              ),
                            ),
                          },
                        ],
                      ),
                      vSpacingFive,
                      vSpacingFive,
                      if (taskType == TaskType.todo) ...{
                        MenuButton(
                          onMenuTapped: () async => await _beginTaskPopup(
                            ctx: context,
                            taskId: task.id!,
                          ),
                          menuText: StringConstants.beginTask,
                        ),
                        vSpacingFive,
                      },
                      if (taskType == TaskType.ongoing) ...{
                        MenuButton(
                          onMenuTapped: () async {
                            await _completeTaskPopup(
                                ctx: context, taskId: task.id!);
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
                      ),
                      if (taskType == TaskType.completed) ...{
                        vSpacingFive,
                        MenuButton(
                          onMenuTapped: () async {
                            await _reopenTaskPopup(
                              ctx: context,
                              taskId: task.id!,
                            );
                          },
                          menuText: StringConstants.reopenTask,
                        ),
                      },
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _beginTaskPopup({
    BuildContext? ctx,
    required String taskId,
  }) async {
    final context = ctx ?? appNavigatorKey.currentContext!;

    await showPopUp(
        title: StringConstants.popupTitle,
        subTitle: StringConstants.popupSubTitle,
        leftButtonText: StringConstants.cancel,
        rightButtonText: StringConstants.confirm,
        onPressLeft: Navigator.of(context).pop,
        onPressRight: () async {
          Navigator.of(context).pop();
          if (ctx != null) {
            Navigator.of(context).pop();
          }
          try {
            await Injector.resolve<LocalDataUseCase>().insertTaskTime(
              taskId: taskId,
              startTime: DateTime.now().toString(),
            );

            if (context.mounted) {
              refreshBloc(context);
            }
          } catch (e) {
            if (context.mounted) {
              showBottomMessage(context, message: '$e');
            }
          }
        });
  }

  Future<void> _completeTaskPopup({
    BuildContext? ctx,
    required String taskId,
  }) async {
    final context = ctx ?? appNavigatorKey.currentContext!;

    await showPopUp(
        title: StringConstants.popupTitle,
        subTitle: StringConstants.popupSubTitle,
        leftButtonText: StringConstants.cancel,
        rightButtonText: StringConstants.confirm,
        onPressLeft: Navigator.of(context).pop,
        onPressRight: () async {
          if (context.mounted) {
            Navigator.of(context).pop();
            if (ctx != null) {
              Navigator.of(context).pop();
            }
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
                refreshBloc(context);
              }
            } catch (e) {
              if (context.mounted) {
                showBottomMessage(context, message: '$e');
              }
            }
          }
        });
  }

  Future<void> _reopenTaskPopup({
    BuildContext? ctx,
    required String taskId,
  }) async {
    final context = ctx ?? appNavigatorKey.currentContext!;

    await showPopUp(
        title: StringConstants.popupTitle,
        subTitle: StringConstants.popupSubTitle,
        leftButtonText: StringConstants.cancel,
        rightButtonText: StringConstants.confirm,
        onPressLeft: Navigator.of(context).pop,
        onPressRight: () async {
          Navigator.of(context).pop();
          if (ctx != null) {
            Navigator.of(context).pop();
          }
          try {
            await Injector.resolve<LocalDataUseCase>().deleteTaskTime(taskId);
            if (context.mounted) {
              refreshBloc(context);
            }
          } catch (e) {
            if (context.mounted) {
              showBottomMessage(context, message: '$e');
            }
          }
        });
  }

  Future<void> _addCommentPopup({
    BuildContext? ctx,
    required String taskId,
  }) async {
    final context = ctx ?? appNavigatorKey.currentContext!;

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

  _openBottomSheetForViewComments({BuildContext? ctx, required String taskId}) {
    final context = ctx ?? appNavigatorKey.currentContext!;

    final deviceHeight = MediaQuery.of(context).size.height;

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
              StyledText.headlineSmall(StringConstants.viewComments),
              vSpacingFive,
              vSpacingFive,
              SizedBox(
                height: deviceHeight * 0.4,
                child: ViewComments(
                  taskId: taskId,
                  onDeleteClicked: (String commentId) async {
                    await _deleteCommentPopup(context, commentId);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _deleteCommentPopup(BuildContext context, String commentId) async {
    await showPopUp(
        title: StringConstants.popupTitle,
        subTitle: StringConstants.popupSubTitle,
        leftButtonText: StringConstants.cancel,
        rightButtonText: StringConstants.confirm,
        onPressLeft: Navigator.of(context).pop,
        onPressRight: () async {
          if (context.mounted) {
            try {
              Navigator.of(context).pop();
              Navigator.of(context).pop();

              await Injector.resolve<CommentUseCase>().deleteComment(
                commentId: commentId,
              );

              refreshBloc(context);
            } catch (e) {
              if (context.mounted) {
                showBottomMessage(context, message: '$e');
              }
            }
          }
        });
  }

  void _manageDropTask(
      String taskId, TaskType fromTaskType, TaskType toTaskType) {
    if (fromTaskType == TaskType.todo) {
      if (toTaskType == TaskType.ongoing) {
        _beginTaskPopup(taskId: taskId);
      }
      if (toTaskType == TaskType.completed) {
        /// Todo  : check start time
        _completeTaskPopup(taskId: taskId);
      }
      return;
    }

    if (fromTaskType == TaskType.ongoing) {
      if (toTaskType == TaskType.todo) {
        _reopenTaskPopup(taskId: taskId);
      }
      if (toTaskType == TaskType.completed) {
        _completeTaskPopup(taskId: taskId);
      }
      return;
    }

    if (fromTaskType == TaskType.completed) {
      if (toTaskType == TaskType.todo) {
        _reopenTaskPopup(taskId: taskId);
      }
      if (toTaskType == TaskType.ongoing) {
        /// Todo  : clear end time, update start time
      }
      return;
    }
  }
}
