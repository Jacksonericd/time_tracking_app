import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_button.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/custom_text_field_bloc_builder.dart';
import 'package:time_tracking_app/core/presentation/widgets/form_bloc_select_list.dart';
import 'package:time_tracking_app/core/presentation/widgets/loading_dialog.dart';
import 'package:time_tracking_app/core/presentation/widgets/show_bottom_message.dart';
import 'package:time_tracking_app/presentation/bloc/form_bloc/add_edit_form_bloc.dart';

class AddEditTask extends StatelessWidget {
  const AddEditTask({
    super.key,
    this.isEditMode = false,
    required this.sectionId,
    this.taskId,
  });

  final bool isEditMode;
  final String sectionId;
  final String? taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditTaskFormBloc(),
      child: Builder(builder: (context) {
        final formBloc = BlocProvider.of<AddEditTaskFormBloc>(context);
        formBloc.boolIsEditMode.updateValue(isEditMode);
        formBloc.tfTSectionId.updateValue(sectionId);
        if (taskId != null) {
          formBloc.tfTaskId.updateValue(taskId!);
        }

        return AppScaffold(
          hideAppBar: false,
          appBar: AppBar(
            title: Text('${isEditMode ? 'Edit' : 'Add'} task'),
          ),
          scaffoldBody: FormBlocListener<AddEditTaskFormBloc, String, String>(
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
                child: AppScaffold(
                    scaffoldBody: Column(
                  children: [
                    CustomTextFieldBlocBuilder(
                      textFieldBloc: formBloc.tfTaskContent,
                      maxLength: 30,
                      labelText: StringConstants.taskContent,
                    ),
                    CustomTextFieldBlocBuilder(
                      textFieldBloc: formBloc.tfTaskDescription,
                      maxLength: 100,
                      labelText: StringConstants.taskDescription,
                      maxLines: 5,
                      inputType: TextInputType.multiline,
                    ),
                    DateTimeFieldBlocBuilder(
                        dateTimeFieldBloc: formBloc.dueDateTime,
                        format: DateFormat('dd-MM-yyyy  hh:mm a '),
                        canSelectTime: true,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365))),
                    FormBlocSelectList(
                      selectFieldBloc: formBloc.selectPriority,
                      defaultText: StringConstants.priority,
                    ),
                    CustomTextFieldBlocBuilder(
                      textFieldBloc: formBloc.tfDurationInHours,
                      maxLength: 2,
                      labelText: StringConstants.durationInHours,
                      inputType: const TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                    ),
                    AppButton(
                      buttonText: StringConstants.submit,
                      onButtonClicked: formBloc.submit,
                    )
                  ],
                ))),
          ),
        );
      }),
    );
  }
}
