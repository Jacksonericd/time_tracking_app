import 'package:time_tracking_app/domain/repo_abstract/local_data_abstract.dart';

class LocalDataUseCase {
  final LocalDataAbstract localDataAbstract;

  LocalDataUseCase(this.localDataAbstract);

  Future<dynamic> initDatabase() => localDataAbstract.initDatabase();

  Future<dynamic> getTaskTimerById(String taskId) =>
      localDataAbstract.getTaskTimerById(taskId);

  Future<dynamic> getAllTaskTimer() => localDataAbstract.getAllTaskTimer();

  Future<void> insertTaskTime(
          {required String taskId, required String startTime}) =>
      localDataAbstract.insertTaskTime(taskId: taskId, startTime: startTime);

  Future<void> updateTaskStartTime(
          {required String taskId, required String startTime}) =>
      localDataAbstract.updateTaskStartTime(
          taskId: taskId, startTime: startTime);

  Future<void> updateTaskEndTime(
          {required String taskId, required String endTime}) =>
      localDataAbstract.updateTaskEndTime(
        taskId: taskId,
        endTime: endTime,
      );

  Future<void> deleteTaskTime(String taskId) =>
      localDataAbstract.deleteTaskTime(taskId);
}
