import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/enums/bloc_states.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/data/model/comment.dart';
import 'package:time_tracking_app/domain/usecases/comment_usecase.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentsLoadingState()) {
    on<CommentEvent>(_init);
  }

  void _init(CommentEvent event, Emitter<CommentState> emit) async {
    emit(CommentsLoadingState());

    if (event is GetCommentsByTask) {
      try {
        dynamic response = await Injector.resolve<CommentUseCase>()
            .getCommentsByTask(taskId: event.taskId);
        final comments = (response as List)
            .map((section) => Comment.fromJson(section))
            .toList();

        emit(CommentsLoadedState(commentsList: comments));
      } catch (e) {
        if (e is DioException) {
          emit(CommentsErrorState(error: '${e.error}'));
          return;
        }
        emit(CommentsErrorState(error: '$e'));
      }
    }
  }
}
