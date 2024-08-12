part of 'comment_bloc.dart';

abstract class CommentEvent {}

class GetCommentsByTask extends CommentEvent {
  final String taskId;

  GetCommentsByTask({required this.taskId});
}
