import 'package:time_tracking_app/data/datasources/local/app_local_datasource.dart';
import 'package:time_tracking_app/domain/repo_abstract/local_data_abstract.dart';

class LocalDataRepo extends LocalDataAbstract {
  final AppLocalDatasource appLocalDatasource;

  LocalDataRepo(this.appLocalDatasource);

  @override
  Future<void> deleteTaskTime(String taskId) =>
      appLocalDatasource.deleteTaskTime(taskId);

  @override
  Future getTaskTimerById(String taskId) =>
      appLocalDatasource.getTaskTimerById(taskId);

  @override
  Future<void> insertTaskTime(
          {required String taskId, required String startTime}) =>
      appLocalDatasource.insertTaskTime(taskId: taskId, startTime: startTime);

  @override
  Future<void> updateTaskTime(
          {required String taskId, required String startTime}) =>
      appLocalDatasource.updateTaskTime(taskId: taskId, startTime: startTime);
}
