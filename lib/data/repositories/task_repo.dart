import 'package:time_tracking_app/data/datasources/remote/task_remote_datasource.dart';
import 'package:time_tracking_app/domain/repo_abstract/task_abstract.dart';

class TaskRepo extends TaskAbstract {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepo(this.taskRemoteDataSource);

  @override
  Future getTasksByProjectAndSection({
    required String projectId,
    required String sectionId,
  }) async =>
      taskRemoteDataSource.getTasksByProjectAndSection(
        projectId: projectId,
        sectionId: sectionId,
      );

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
  Future closeTask({required String taskId}) async =>
      taskRemoteDataSource.closeTask(
        taskId: taskId,
      );
}
