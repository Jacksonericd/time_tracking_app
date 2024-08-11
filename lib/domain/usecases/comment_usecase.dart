import 'package:time_tracking_app/domain/repo_abstract/comment_abstract.dart';

class CommentUseCase {
  final CommentAbstract commentAbstract;

  CommentUseCase(this.commentAbstract);

  Future<dynamic> getCommentsByTask({
    required String taskId,
  }) =>
      commentAbstract.getCommentsByTask(
        taskId: taskId,
      );

  Future<dynamic> getCommentById({
    required String commentId,
  }) =>
      commentAbstract.getCommentById(
        commentId: commentId,
      );

  Future<dynamic> createComment({
    required Map inputData,
  }) =>
      commentAbstract.createComment(
        inputData: inputData,
      );

  Future<dynamic> updateComment({
    required String commentId,
    required Map inputData,
  }) =>
      commentAbstract.updateComment(
        commentId: commentId,
        inputData: inputData,
      );

  Future<dynamic> deleteComment({
    required String commentId,
  }) =>
      commentAbstract.deleteComment(
        commentId: commentId,
      );
}
