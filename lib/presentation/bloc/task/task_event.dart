part of 'task_bloc.dart';

abstract class TaskEvent {}

class GetTasksByProjectEvent extends TaskEvent {
  final String projectId;

  GetTasksByProjectEvent({
    required this.projectId,
  });
}

class FilerTasksEvent extends TaskEvent {
  final List<Task> allTasks;

  FilerTasksEvent({required this.allTasks});
}
