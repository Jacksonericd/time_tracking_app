abstract class TaskAbstract {
  Future<dynamic> getTasksByProjectId({
    required String projectId,
    String? sectionId,
  });

  Future<dynamic> getTasksById({
    required String taskId,
  });

  Future getCompletedTasksByProject({required String projectId});

  Future<dynamic> createTask({
    required Map inputData,
  });

  Future<dynamic> updateTask({
    required String taskId,
    required Map inputData,
  });

  Future<dynamic> completeTask({required String taskId});
}
