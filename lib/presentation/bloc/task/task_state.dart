part of 'task_bloc.dart';

class TaskState {
  final BlocStates blocStates;
  final String? message;
  final List<Task>? taskTodoList;
  final List<Task>? taskOngoingList;
  final List<CompletedItem>? taskCompletedList;

  TaskState({
    required this.blocStates,
    this.message,
    this.taskTodoList,
    this.taskOngoingList,
    this.taskCompletedList,
  });
}

class TasksLoadingState extends TaskState {
  TasksLoadingState() : super(blocStates: BlocStates.loading);
}

class TasksLoadedState extends TaskState {
  final List<Task>? taskTodoList;
  final List<Task>? taskOngoingList;
  final List<CompletedItem>? taskCompletedList;

  TasksLoadedState({
    required this.taskTodoList,
    this.taskOngoingList,
    this.taskCompletedList,
  }) : super(
          blocStates: BlocStates.loaded,
          taskTodoList: taskTodoList,
          taskOngoingList: taskOngoingList,
          taskCompletedList: taskCompletedList,
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
