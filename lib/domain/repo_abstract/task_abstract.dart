abstract class TaskAbstract {
  Future<dynamic> getTasksByProjectAndSection({
    required String projectId,
    String? sectionId,
  });

  Future getCompletedTasksByProject({required String projectId});

  Future<dynamic> createTask({
    required Map inputData,
  });

  Future<dynamic> updateTask({
    required String taskId,
    required Map inputData,
  });

  Future<dynamic> completeTask();
}
