import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:time_tracking_app/core/config/navigator_key.dart';
import 'package:time_tracking_app/core/functions/custom_bloc_validators.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/presentation/widgets/loading_dialog.dart';
import 'package:time_tracking_app/data/model/comment.dart';
import 'package:time_tracking_app/domain/usecases/comment_usecase.dart';

class AddEditCommentFormBloc extends FormBloc<String, String> {
  final tfTaskId = TextFieldBloc();
  final tfCommentId = TextFieldBloc();
  final tfCommentContent =
      TextFieldBloc(validators: [CustomBlocValidators.requiredCommentContent]);
  final boolIsEditMode = BooleanFieldBloc(initialValue: false);

  AddEditCommentFormBloc() : super(isLoading: true, autoValidate: true) {
    addFieldBlocs(fieldBlocs: [
      tfTaskId,
      tfCommentContent,
      boolIsEditMode,
    ]);
  }

  @override
  FutureOr<void> onLoading() async {
    try {
      if (!boolIsEditMode.value) {
        emitLoaded();
        return;
      }

      LoadingDialog.show(appNavigatorKey.currentContext!);

      final response = await Injector.resolve<CommentUseCase>().getCommentById(
        commentId: tfCommentId.value,
      );

      final comment = Comment.fromJson(response);

      tfCommentContent.updateValue(comment.content!);

      emitLoaded();
    } catch (e) {
      emitLoadFailed(failureResponse: '$e');
    } finally {
      if (boolIsEditMode.value) {
        LoadingDialog.hide(appNavigatorKey.currentContext!);
      }
    }
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      final Map inputData = {
        'content': tfCommentContent.value,
      };

      if (!boolIsEditMode.value) {
        inputData.addAll({
          'task_id': tfTaskId.value,
        });
      }

      if (boolIsEditMode.value) {
        await Injector.resolve<CommentUseCase>().updateComment(
          inputData: inputData,
          commentId: tfCommentId.value,
        );
      } else {
        await Injector.resolve<CommentUseCase>().createComment(
          inputData: inputData,
        );
      }

      final message =
          'Comment ${boolIsEditMode.value ? 'updated' : 'added'} successfully!';
      emitSuccess(successResponse: message);
    } catch (e) {
      emitFailure(failureResponse: '$e');
    }
  }
}
