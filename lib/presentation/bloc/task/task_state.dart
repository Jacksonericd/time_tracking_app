part of 'task_bloc.dart';

class TaskState {
  final BlocStates blocStates;
  final String? message;
  final List<Task>? tasks;

  TaskState({
    required this.blocStates,
    this.message,
    this.tasks,
  });
}

class TasksLoadingState extends TaskState {
  TasksLoadingState() : super(blocStates: BlocStates.loading);
}

class TasksLoadedState extends TaskState {
  final List<Task>? taskList;

  TasksLoadedState({required this.taskList})
      : super(
          blocStates: BlocStates.loaded,
          tasks: taskList,
        );
}

class TasksErrorState extends TaskState {
  final String error;

  TasksErrorState({required this.error})
      : super(
          blocStates: BlocStates.error,
          message: error,
        );
}
