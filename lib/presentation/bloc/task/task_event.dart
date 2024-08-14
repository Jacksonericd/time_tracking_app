part of 'task_bloc.dart';

abstract class TaskEvent {}

class GetTasksByProjectEvent extends TaskEvent {
  final String projectId;

  GetTasksByProjectEvent({
    required this.projectId,
  });
}

class BeginTasksEvent extends TaskEvent {
  final String taskId;

  BeginTasksEvent({
    required this.taskId,
  });
}

class CompleteTasksEvent extends TaskEvent {
  final String taskId;

  CompleteTasksEvent({
    required this.taskId,
  });
}

class ReopenTasksEvent extends TaskEvent {
  final String taskId;

  ReopenTasksEvent({
    required this.taskId,
  });
}
