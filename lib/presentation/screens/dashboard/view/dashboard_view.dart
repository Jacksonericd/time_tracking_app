import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/image_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/enums/task_type.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_button.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/asset_image.dart';
import 'package:time_tracking_app/core/presentation/widgets/bloc_state_widget.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/data/model/completed_items.dart';
import 'package:time_tracking_app/data/model/sections.dart';
import 'package:time_tracking_app/data/model/task.dart';
import 'package:time_tracking_app/domain/usecases/local_data_usecase.dart';
import 'package:time_tracking_app/presentation/bloc/section/section_bloc.dart';
import 'package:time_tracking_app/presentation/bloc/task/task_bloc.dart';

import '../widgets/completed_tasks.dart';
import '../widgets/scrollable_tasks.dart';
import '../widgets/task_summary_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

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

  Widget get introWidget => Column(
        children: [
          StyledText.displayMedium(StringConstants.welcomeComma),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc()
        ..add(GetTasksByProjectAndSectionEvent(
          projectId: '2337659677',
        )),
      child: AppScaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
          onPressed: () =>
              Navigator.of(context).pushNamed(RouteConstants.addTaskPath),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        scaffoldBody: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return BlocStateToWidget(
              message: state.message ?? '',
              blocStates: state.blocStates,
              child: displayData(
                state,
                context,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget displayData(TaskState state, BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final todoTasks = state.taskTodoList;
    final ongoingTasks = state.taskOngoingList;
    final completedTasks = state.taskCompletedList;

    final topContent = [
      topSpacing,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          introWidget,
          appLogo,
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        height: 35,
        width: deviceWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).cardColor),
        alignment: Alignment.center,
        child: StyledText.titleMedium(StringConstants.taskSummary),
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
              )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              flex: 1,
              child: TaskSummaryCard(
                headingText: StringConstants.ongoing,
                valueText: '${ongoingTasks?.length}',
              )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              flex: 1,
              child: TaskSummaryCard(
                headingText: StringConstants.completed,
                valueText: '${completedTasks?.length}',
              )),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ];

    final bottomContent = [
      const SizedBox(
        height: 10,
      ),
      ScrollableTasks(
        taskType: TaskType.todo,
        tasks: todoTasks,
      ),
      const SizedBox(
        height: 10,
      ),
      ScrollableTasks(
        taskType: TaskType.ongoing,
        tasks: ongoingTasks,
      ),
      const SizedBox(
        height: 10,
      ),
      CompletedTasks(
        tasks: completedTasks,
      ),
    ];

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
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              child: Container(
                color: Theme.of(context).primaryColorLight,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: bottomContent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  displayTodoTasksDataList(List<Task>? tasks, BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    Widget dataWidget = const Text('No sections found');

    if ((tasks ?? []).isNotEmpty) {
      dataWidget = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tasks!.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return Container(
              width: deviceWidth * 0.9,
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.yellow,
              ),
              child: Column(
                children: [
                  Text(task.content!),
                  AppButton(
                      buttonText: StringConstants.beginTask,
                      onButtonClicked: () =>
                          _beginTask(taskId: task.id!, context: context)),
                  AppButton(
                      buttonText: StringConstants.addComment,
                      onButtonClicked: () => Navigator.of(context).pushNamed(
                          RouteConstants.addCommentPath,
                          arguments: {'task-id': task.id!})),
                  AppButton(
                      buttonText: StringConstants.viewComments,
                      onButtonClicked: () => Navigator.of(context).pushNamed(
                          RouteConstants.viewTaskCommentPath,
                          arguments: {'task-id': task.id!})),
                ],
              ),
            );
          });
    }

    return dataWidget;
  }

  displayOngoingTasksDataList(List<Task>? tasks, BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    Widget dataWidget = const Text('No sections found');

    if ((tasks ?? []).isNotEmpty) {
      dataWidget = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tasks!.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RouteConstants.taskListPath, arguments: task.id);
              },
              child: Container(
                width: deviceWidth * 0.9,
                height: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.yellow,
                ),
                child: Column(
                  children: [
                    Text(task.content!),
                    AppButton(
                        buttonText: StringConstants.completeTask,
                        onButtonClicked: () =>
                            _completeTask(taskId: task.id!, context: context)),
                    AppButton(
                      buttonText: StringConstants.edit,
                      onButtonClicked: () => Navigator.of(context).pushNamed(
                        RouteConstants.editTaskPath,
                        arguments: {
                          'task-id': task.id,
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return dataWidget;
  }

  displayCompletedTasksDataList(
      List<CompletedItem>? tasks, BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    Widget dataWidget = const Text('No sections found');

    if ((tasks ?? []).isNotEmpty) {
      dataWidget = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tasks!.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RouteConstants.taskListPath, arguments: task.id);
              },
              child: Container(
                width: deviceWidth * 0.9,
                height: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.yellow,
                ),
                child: Text(task.content!),
              ),
            );
          });
    }

    return dataWidget;
  }

  _beginTask({required String taskId, required BuildContext context}) async {
    try {
      await Injector.resolve<LocalDataUseCase>()
          .insertTaskTime(taskId: taskId, startTime: DateTime.now().toString());
    } catch (e) {}
  }

  _completeTask({required String taskId, required BuildContext context}) async {
    try {
      await Injector.resolve<LocalDataUseCase>().deleteTaskTime(taskId);

      //To-do : find the timer differenec
      // call update duration
      // call complete task
    } catch (e) {}
  }
}
