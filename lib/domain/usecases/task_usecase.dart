import 'package:time_tracking_app/domain/repo_abstract/task_abstract.dart';

class TaskUseCase {
  final TaskAbstract taskAbstract;

  TaskUseCase(this.taskAbstract);

  Future<dynamic> getTasksByProjectAndSection({
    required String projectId,
    required String sectionId,
  }) =>
      taskAbstract.getTasksByProjectAndSection(
        projectId: projectId,
        sectionId: sectionId,
      );

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

  Future<dynamic> closeTask({
    required String taskId,
  }) =>
      taskAbstract.closeTask(
        taskId: taskId,
      );
}
