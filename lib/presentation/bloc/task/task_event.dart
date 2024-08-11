part of 'task_bloc.dart';

abstract class TaskEvent {}

class GetTasksByProjectAndSectionEvent extends TaskEvent {
  final String projectId;
  final String sectionId;

  GetTasksByProjectAndSectionEvent({
    required this.projectId,
    required this.sectionId,
  });
}
