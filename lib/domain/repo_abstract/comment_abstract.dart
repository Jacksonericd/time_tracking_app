abstract class CommentAbstract {
  Future<dynamic> getCommentsByTask({
    required String taskId,
  });

  Future<dynamic> getCommentById({
    required String commentId,
  });

  Future<dynamic> createComment({
    required Map inputData,
  });

  Future<dynamic> updateComment({
    required String commentId,
    required Map inputData,
  });

  Future<dynamic> deleteComment({
    required String commentId,
  });
}
