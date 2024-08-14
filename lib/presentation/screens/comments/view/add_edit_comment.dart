import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_button.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/custom_text_field_bloc_builder.dart';
import 'package:time_tracking_app/core/presentation/widgets/loading_dialog.dart';
import 'package:time_tracking_app/core/presentation/widgets/show_bottom_message.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/presentation/bloc/form_bloc/add_edit_comment_form_bloc.dart';

class AddEditComment extends StatelessWidget {
  const AddEditComment({
    super.key,
    this.isEditMode = false,
    this.commentId,
    this.taskId,
  });

  final bool isEditMode;
  final String? commentId;
  final String? taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditCommentFormBloc(),
      child: Builder(builder: (context) {
        final formBloc = BlocProvider.of<AddEditCommentFormBloc>(context);
        formBloc.boolIsEditMode.updateValue(isEditMode);

        if (taskId != null) {
          formBloc.tfTaskId.updateValue(taskId!);
        }

        if (commentId != null) {
          formBloc.tfCommentId.updateValue(commentId!);
        }

        return FormBlocListener<AddEditCommentFormBloc, String, String>(
          onSubmitting: (context, state) {
            LoadingDialog.show(context);
          },
          onSubmissionCancelled: (context, state) {
            LoadingDialog.hide(context);
          },
          onSubmissionFailed: (context, state) {
            LoadingDialog.hide(context);
          },
          onSuccess: (context, state) {
            LoadingDialog.hide(context);

            showBottomMessage(
              context,
              message: state.successResponse!,
              success: true,
            );
          },
          onFailure: (context, state) {
            LoadingDialog.hide(context);

            showBottomMessage(
              context,
              message: state.failureResponse!,
            );
          },
          child: ScrollableFormBlocManager(
              formBloc: formBloc,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFieldBlocBuilder(
                      textFieldBloc: formBloc.tfCommentContent,
                      maxLength: 30,
                      labelText: StringConstants.commentContent,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButton(
                          buttonText: StringConstants.cancel,
                          onButtonClicked: Navigator.of(context).pop,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        AppButton(
                          buttonText: StringConstants.submit,
                          onButtonClicked: formBloc.submit,
                        ),
                      ],
                    )
                  ],
                ),
              )),
        );
      }),
    );
    return AppScaffold(
      hideAppBar: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: StyledText.titleLarge('${isEditMode ? 'Edit' : 'Add'} comment'),
      ),
      scaffoldBody: BlocProvider(
        create: (context) => AddEditCommentFormBloc(),
        child: Builder(builder: (context) {
          final formBloc = BlocProvider.of<AddEditCommentFormBloc>(context);
          formBloc.boolIsEditMode.updateValue(isEditMode);

          if (taskId != null) {
            formBloc.tfTaskId.updateValue(taskId!);
          }

          if (commentId != null) {
            formBloc.tfCommentId.updateValue(commentId!);
          }

          return FormBlocListener<AddEditCommentFormBloc, String, String>(
            onSubmitting: (context, state) {
              LoadingDialog.show(context);
            },
            onSubmissionCancelled: (context, state) {
              LoadingDialog.hide(context);
            },
            onSubmissionFailed: (context, state) {
              LoadingDialog.hide(context);
            },
            onSuccess: (context, state) {
              LoadingDialog.hide(context);

              showBottomMessage(
                context,
                message: state.successResponse!,
                success: true,
              );
            },
            onFailure: (context, state) {
              LoadingDialog.hide(context);

              showBottomMessage(
                context,
                message: state.failureResponse!,
              );
            },
            child: ScrollableFormBlocManager(
                formBloc: formBloc,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 24),
                  child: Column(
                    children: [
                      CustomTextFieldBlocBuilder(
                        textFieldBloc: formBloc.tfCommentContent,
                        maxLength: 30,
                        labelText: StringConstants.commentContent,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppButton(
                        buttonText: StringConstants.submit,
                        onButtonClicked: formBloc.submit,
                      )
                    ],
                  ),
                )),
          );
        }),
      ),
    );
  }
}
