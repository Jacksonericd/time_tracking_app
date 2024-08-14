import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/config/navigator_key.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/image_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/enums/task_type.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/asset_image.dart';
import 'package:time_tracking_app/core/presentation/widgets/bloc_state_widget.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/presentation/bloc/task/task_bloc.dart';

import '../widgets/scrollable_tasks.dart';
import '../widgets/task_summary_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  static const projectId = '2337659677';

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
            child: displayData(
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

  Widget displayData(TaskState state, BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final todoTasks = state.taskTodoList;
    final ongoingTasks = state.taskOngoingList;
    final completedTasks = state.taskCompList;
    // final completedTasks = state.taskCompletedList;

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

    final bottomContent = [
      ScrollableTasks(
        taskType: TaskType.todo,
        tasks: todoTasks,
        refreshBloc: () => refreshBloc(context),
      ),
      const SizedBox(
        height: 20,
      ),
      ScrollableTasks(
        taskType: TaskType.ongoing,
        tasks: ongoingTasks,
        refreshBloc: () => refreshBloc(context),
      ),
      const SizedBox(
        height: 20,
      ),
      ScrollableTasks(
        taskType: TaskType.completed,
        tasks: completedTasks,
        refreshBloc: () => refreshBloc(context),
      ),
      const SizedBox(
        height: 70,
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
}
