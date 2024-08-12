import 'package:time_tracking_app/core/services/local_storage/local_storage_service.dart';

class AppLocalDatasource {
  final LocalStorageService localStorageService;

  AppLocalDatasource(this.localStorageService);

  Future<void> deleteTaskTime(String taskId) =>
      localStorageService.deleteTaskTime(taskId);

  Future getTaskTimerById(String taskId) =>
      localStorageService.getTaskTimerById(taskId);

  Future<void> insertTaskTime(
          {required String taskId, required String startTime}) =>
      localStorageService.insertTaskTime(taskId: taskId, startTime: startTime);

  Future<void> updateTaskTime(
          {required String taskId, required String startTime}) =>
      localStorageService.updateTaskTime(taskId: taskId, startTime: startTime);
}
