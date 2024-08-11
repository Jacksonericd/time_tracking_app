import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/bloc_state_widget.dart';
import 'package:time_tracking_app/data/model/task.dart';
import 'package:time_tracking_app/presentation/bloc/task/task_bloc.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    required this.sectionId,
    super.key,
  });

  final String sectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc()
        ..add(GetTasksByProjectAndSectionEvent(
          projectId: '2337659677',
          sectionId: sectionId,
        )),
      child: AppScaffold(
        hideAppBar: false,
        appBar: AppBar(
          title: Text('Tasks under section'),
        ),
        scaffoldBody: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return BlocStateToWidget(
              message: state.message ?? '',
              blocStates: state.blocStates,
              child: displaySectionsData(
                state.tasks,
                context,
              ),
            );
          },
        ),
      ),
    );
  }

  displaySectionsData(List<Task>? tasks, BuildContext context) {
    if ((tasks ?? []).isEmpty) {
      return const Text('No sections found');
    }

    final deviceWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: tasks!.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Container(
            width: deviceWidth * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
            child: Text(task.content!),
          );
        });
  }
}
