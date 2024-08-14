import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_button.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/bloc_state_widget.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/data/model/comment.dart';
import 'package:time_tracking_app/presentation/bloc/comment/comment_bloc.dart';

import 'add_edit_comment.dart';

class ViewComments extends StatelessWidget {
  const ViewComments({
    required this.taskId,
    super.key,
  });

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentBloc()..add(GetCommentsByTask(taskId: taskId)),
      child: AppScaffold(
        hideAppBar: false,
        appBar: AppBar(
          title: Text('Comments under task'),
        ),
        scaffoldBody: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            return BlocStateToWidget(
              message: state.message ?? '',
              blocStates: state.blocStates,
              child: displayCommentsData(
                state.comments,
                context,
              ),
            );
          },
        ),
      ),
    );
  }

  displayCommentsData(List<Comment>? comments, BuildContext context) {
    if ((comments ?? []).isEmpty) {
      return const Text('No comments found');
    }

    final deviceWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: comments!.length,
        itemBuilder: (context, index) {
          final comment = comments[index];

          return Container(
            width: deviceWidth * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(comment.content!),
                AppButton(
                  buttonText: StringConstants.edit,
                  onButtonClicked: () => _editCommentPopup(
                    context,
                    comment.id!,
                  ),
                  // onButtonClicked: () => Navigator.of(context).pushNamed(
                  //   RouteConstants.editCommentPath,
                  //   arguments: {
                  //     'comment-id': comment.id,
                  //   },
                  // ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _editCommentPopup(
    BuildContext context,
    String commentId,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
            child: StyledText.headlineSmall(StringConstants.updateComment)),
        content: AddEditComment(
          isEditMode: true,
          commentId: commentId,
        ),
      ),
    );
  }
}
