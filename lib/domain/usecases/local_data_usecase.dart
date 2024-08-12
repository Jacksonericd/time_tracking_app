import 'package:time_tracking_app/domain/repo_abstract/local_data_abstract.dart';

class LocalDataUseCase {
  final LocalDataAbstract localDataAbstract;

  LocalDataUseCase(this.localDataAbstract);

  Future<dynamic> getTaskTimerById(String taskId) =>
      localDataAbstract.getTaskTimerById(taskId);

  Future<void> insertTaskTime(
          {required String taskId, required String startTime}) =>
      localDataAbstract.insertTaskTime(taskId: taskId, startTime: startTime);

  Future<void> updateTaskTime(
          {required String taskId, required String startTime}) =>
      localDataAbstract.updateTaskTime(taskId: taskId, startTime: startTime);

  Future<void> deleteTaskTime(String taskId) =>
      localDataAbstract.deleteTaskTime(taskId);
}
