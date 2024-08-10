abstract class TaskAbstract {
  Future<dynamic> getTasksByProjectAndSection({
    required String projectId,
    required String sectionId,
  });

  Future<dynamic> createTask({
    required Map inputData,
  });

  Future<dynamic> updateTask({
    required String taskId,
    required Map inputData,
  });

  Future<dynamic> closeTask({
    required String taskId,
  });
}
