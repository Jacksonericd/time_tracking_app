import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_button.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/bloc_state_widget.dart';
import 'package:time_tracking_app/data/model/completed_items.dart';
import 'package:time_tracking_app/data/model/sections.dart';
import 'package:time_tracking_app/data/model/task.dart';
import 'package:time_tracking_app/domain/usecases/local_data_usecase.dart';
import 'package:time_tracking_app/presentation/bloc/section/section_bloc.dart';
import 'package:time_tracking_app/presentation/bloc/task/task_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc()
        ..add(GetTasksByProjectAndSectionEvent(
          projectId: '2337659677',
        )),
      child: AppScaffold(
        hideAppBar: false,
        appBar: AppBar(
          title: Text('Sections'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.of(context).pushNamed(
              RouteConstants.addTaskPath,
              arguments: {'section-id': 'sectionId'}),
        ),
        scaffoldBody: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return BlocStateToWidget(
              message: state.message ?? '',
              blocStates: state.blocStates,
              child: displayTasksData(
                state,
                context,
              ),
            );
          },
        ),
      ),
    );
    return BlocProvider(
      create: (context) => SectionBloc()
        ..add(GetSectionsEvent(
          projectId: '2337659677',
        )),
      child: AppScaffold(
        hideAppBar: false,
        appBar: AppBar(
          title: Text('Sections'),
        ),
        scaffoldBody: BlocBuilder<SectionBloc, SectionState>(
          builder: (context, state) {
            return BlocStateToWidget(
              message: state.message ?? '',
              blocStates: state.blocStates,
              child: displaySectionsData(
                state.sections,
                context,
              ),
            );
          },
        ),
      ),
    );
  }

  displaySectionsData(List<Sections>? sections, BuildContext context) {
    if ((sections ?? []).isEmpty) {
      return const Text('No sections found');
    }

    final deviceWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: sections!.length,
        itemBuilder: (context, index) {
          final section = sections[index];

          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RouteConstants.taskListPath,
                  arguments: section.id);
            },
            child: Container(
              width: deviceWidth * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
              child: Text(section.name!),
            ),
          );
        });
  }

  Widget displayTasksData(TaskState state, BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final todoTasks = state.taskTodoList;
    final ongoingTasks = state.taskOngoingList;
    final completedTasks = state.taskCompletedList;

    return Column(
      children: [
        Container(
          width: deviceWidth,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.yellow,
          ),
          child: displayTodoTasksDataList(todoTasks, context),
        ),
        Container(
          width: deviceWidth,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.yellow,
          ),
          child: displayOngoingTasksDataList(ongoingTasks, context),
        ),
        Container(
          width: deviceWidth,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.yellow,
          ),
          child: displayCompletedTasksDataList(completedTasks, context),
        ),
      ],
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
                            arguments: {'task-id': task.id!}))
                  ],
                ),
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
                            _completeTask(taskId: task.id!, context: context))
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
