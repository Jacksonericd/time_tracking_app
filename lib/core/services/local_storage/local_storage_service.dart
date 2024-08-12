abstract class LocalStorageService {
  Future<dynamic> getTaskTimerById(String taskId);

  Future<dynamic> getAllTaskTimer();

  Future<void> insertTaskTime(
      {required String taskId, required String startTime});

  Future<void> updateTaskTime(
      {required String taskId, required String startTime});

  Future<void> deleteTaskTime(String taskId);
}
