abstract class LocalDataAbstract {
  Future<dynamic> getTaskTimerById(String taskId);

  Future<void> insertTaskTime(
      {required String taskId, required String startTime});

  Future<void> updateTaskTime(
      {required String taskId, required String startTime});

  Future<void> deleteTaskTime(String taskId);
}
