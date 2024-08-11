import 'package:time_tracking_app/data/datasources/remote/comment_remote_datasource.dart';
import 'package:time_tracking_app/domain/repo_abstract/comment_abstract.dart';

class CommentsRepo extends CommentAbstract {
  final CommentRemoteDatasource commentRemoteDatasource;

  CommentsRepo(this.commentRemoteDatasource);

  @override
  Future createComment({required Map inputData}) async =>
      commentRemoteDatasource.createComment(
        inputData: inputData,
      );

  @override
  Future deleteComment({required String commentId}) async =>
      commentRemoteDatasource.deleteComment(
        commentId: commentId,
      );

  @override
  Future getCommentById({required String commentId}) =>
      commentRemoteDatasource.getCommentById(
        commentId: commentId,
      );

  @override
  Future getCommentsByTask({required String taskId}) =>
      commentRemoteDatasource.getCommentsByTask(
        taskId: taskId,
      );

  @override
  Future updateComment({required String commentId, required Map inputData}) =>
      commentRemoteDatasource.updateComment(
        commentId: commentId,
        inputData: inputData,
      );
}
