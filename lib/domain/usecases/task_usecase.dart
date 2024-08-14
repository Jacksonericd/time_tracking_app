import 'package:time_tracking_app/domain/repo_abstract/task_abstract.dart';

class TaskUseCase {
  final TaskAbstract taskAbstract;

  TaskUseCase(this.taskAbstract);

  Future<dynamic> getTasksByProjectAndSection({
    required String projectId,
    String? sectionId,
  }) =>
      taskAbstract.getTasksByProjectAndSection(
        projectId: projectId,
        sectionId: sectionId,
      );

  Future<dynamic> getTasksById({
    required String taskId,
  }) =>
      taskAbstract.getTasksById(
        taskId: taskId,
      );

  Future<dynamic> getCompletedTasksByProject({required String projectId}) =>
      taskAbstract.getCompletedTasksByProject(projectId: projectId);

  Future<dynamic> createTask({
    required Map inputData,
  }) =>
      taskAbstract.createTask(
        inputData: inputData,
      );

  Future<dynamic> updateTask({
    required String taskId,
    required Map inputData,
  }) =>
      taskAbstract.updateTask(
        taskId: taskId,
        inputData: inputData,
      );

  Future<dynamic> completeTask({
    required String taskId,
  }) =>
      taskAbstract.completeTask(
        taskId: taskId,
      );
}
