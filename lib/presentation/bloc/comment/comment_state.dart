part of 'comment_bloc.dart';

abstract class CommentState {
  final BlocStates blocStates;
  final String? message;
  final List<Comment>? comments;

  CommentState({
    required this.blocStates,
    this.message,
    this.comments,
  });
}

class CommentsLoadingState extends CommentState {
  CommentsLoadingState() : super(blocStates: BlocStates.loading);
}

class CommentsLoadedState extends CommentState {
  final List<Comment>? commentsList;

  CommentsLoadedState({required this.commentsList})
      : super(
          blocStates: BlocStates.loaded,
          comments: commentsList,
        );
}

class CommentsErrorState extends CommentState {
  final String error;

  CommentsErrorState({required this.error})
      : super(
          blocStates: BlocStates.error,
          message: error,
        );
}
