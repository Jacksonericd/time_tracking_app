import 'package:time_tracking_app/data/datasources/local/app_local_datasource.dart';
import 'package:time_tracking_app/domain/repo_abstract/local_data_abstract.dart';

class LocalDataRepo extends LocalDataAbstract {
  final AppLocalDatasource appLocalDatasource;

  LocalDataRepo(this.appLocalDatasource);

  @override
  Future<void> initDatabase() => appLocalDatasource.initDatabase();

  @override
  Future<void> deleteTaskTime(String taskId) =>
      appLocalDatasource.deleteTaskTime(taskId);

  @override
  Future getTaskTimerById(String taskId) =>
      appLocalDatasource.getTaskTimerById(taskId);

  @override
  Future<void> updateTaskEndTime(
          {required String taskId, required String endTime}) =>
      appLocalDatasource.updateTaskEndTime(
        taskId: taskId,
        endTime: endTime,
      );

  @override
  Future getAllTaskTimer() => appLocalDatasource.getAllTaskTimer();

  @override
  Future<void> insertTaskTime({
    required String taskId,
    required String startTime,
    String? endTime,
  }) =>
      appLocalDatasource.insertTaskTime(
        taskId: taskId,
        startTime: startTime,
        endTime: endTime,
      );

  @override
  Future<void> updateTaskStartTime(
          {required String taskId, required String startTime}) =>
      appLocalDatasource.updateTaskStartTime(
          taskId: taskId, startTime: startTime);
}
