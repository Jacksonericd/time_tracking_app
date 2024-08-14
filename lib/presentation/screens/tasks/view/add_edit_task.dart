import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:time_tracking_app/core/constants/color_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_button.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/custom_text_field_bloc_builder.dart';
import 'package:time_tracking_app/core/presentation/widgets/form_bloc_select_list.dart';
import 'package:time_tracking_app/core/presentation/widgets/loading_dialog.dart';
import 'package:time_tracking_app/core/presentation/widgets/show_bottom_message.dart';
import 'package:time_tracking_app/core/presentation/widgets/styled_text.dart';
import 'package:time_tracking_app/presentation/bloc/form_bloc/add_edit_task_form_bloc.dart';

class AddEditTask extends StatelessWidget {
  const AddEditTask({
    super.key,
    this.isEditMode = false,
    this.taskId,
  });

  final bool isEditMode;
  final String? taskId;

  OutlineInputBorder errorBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorConstants.errorRed),
      );

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder renderBorder() => OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).focusColor),
        );

    return BlocProvider(
      create: (context) => AddEditTaskFormBloc(),
      child: Builder(builder: (context) {
        final formBloc = BlocProvider.of<AddEditTaskFormBloc>(context);
        formBloc.boolIsEditMode.updateValue(isEditMode);
        if (taskId != null) {
          formBloc.tfTaskId.updateValue(taskId!);
        }

        return AppScaffold(
          hideAppBar: false,
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            title: StyledText.titleLarge('${isEditMode ? 'Edit' : 'Add'} task'),
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

              Navigator.of(context).pushNamed(RouteConstants.dashboardPath);
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
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        decoration: InputDecoration(
                          labelText: StringConstants.dueDateTime,
                          filled: true,
                          isDense: true,
                          disabledBorder: renderBorder(),
                          border: renderBorder(),
                          focusedBorder: renderBorder(),
                          enabledBorder: renderBorder(),
                          errorBorder: errorBorder(),
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Theme.of(context).hintColor),
                        ),
                      ),
                      FormBlocSelectList(
                        selectFieldBloc: formBloc.selectPriority,
                        defaultText: StringConstants.priority,
                      ),
                      Visibility(
                        visible: false,
                        child: CustomTextFieldBlocBuilder(
                          textFieldBloc: formBloc.tfDurationInMinutes,
                          maxLength: 4,
                          labelText: StringConstants.durationInMinutes,
                          inputType: const TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                        ),
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
          ),
        );
      }),
    );
  }
}
