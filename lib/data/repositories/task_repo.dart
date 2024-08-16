import 'package:time_tracking_app/data/datasources/remote/task_remote_datasource.dart';
import 'package:time_tracking_app/domain/repo_abstract/task_abstract.dart';

class TaskRepo extends TaskAbstract {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepo(this.taskRemoteDataSource);

  @override
  Future getTasksByProjectId({
    required String projectId,
    String? sectionId,
  }) async =>
      taskRemoteDataSource.getTasksByProjectId(
        projectId: projectId,
        sectionId: sectionId,
      );

  @override
  Future getTasksById({required String taskId}) =>
      taskRemoteDataSource.getTasksById(taskId: taskId);

  @override
  Future createTask({required Map inputData}) =>
      taskRemoteDataSource.createTask(
        inputData: inputData,
      );

  @override
  Future updateTask({
    required String taskId,
    required Map inputData,
  }) =>
      taskRemoteDataSource.updateTask(
        taskId: taskId,
        inputData: inputData,
      );

  @override
  Future completeTask({required String taskId}) async =>
      taskRemoteDataSource.completeTask(
        taskId: taskId,
      );

  @override
  Future getCompletedTasksByProject({required String projectId}) =>
      taskRemoteDataSource.getCompletedTasksByProject(projectId: projectId);
}
