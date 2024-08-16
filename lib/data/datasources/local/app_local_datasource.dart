import 'package:time_tracking_app/core/services/local_storage/local_storage_service.dart';

class AppLocalDatasource {
  final LocalStorageService localStorageService;

  AppLocalDatasource(this.localStorageService);

  Future<void> initDatabase() => localStorageService.initDatabase();

  Future<void> deleteTaskTime(String taskId) =>
      localStorageService.deleteTaskTime(taskId);

  Future getTaskTimerById(String taskId) =>
      localStorageService.getTaskTimerById(taskId);

  Future getAllTaskTimer() => localStorageService.getAllTaskTimer();

  Future<void> insertTaskTime({
    required String taskId,
    required String startTime,
    String? endTime,
  }) =>
      localStorageService.insertTaskTime(
        taskId: taskId,
        startTime: startTime,
        endTime: endTime,
      );

  Future<void> updateTaskStartTime(
          {required String taskId, required String startTime}) =>
      localStorageService.updateTaskStartTime(
          taskId: taskId, startTime: startTime);

  Future<void> updateTaskEndTime(
          {required String taskId, required String endTime}) =>
      localStorageService.updateTaskEndTime(
        taskId: taskId,
        endTime: endTime,
      );
}
