abstract class LocalStorageService {
  Future<void> initDatabase();

  Future<dynamic> getTaskTimerById(String taskId);

  Future<dynamic> getAllTaskTimer();

  Future<dynamic> getAllTaskWithEndTimeNull();

  Future<void> insertTaskTime(
      {required String taskId, required String startTime});

  Future<void> updateTaskStartTime(
      {required String taskId, required String startTime});

  Future<void> updateTaskEndTime(
      {required String taskId, required String endTime});

  Future<void> deleteTaskTime(String taskId);
}
