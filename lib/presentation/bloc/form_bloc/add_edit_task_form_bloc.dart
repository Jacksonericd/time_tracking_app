import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:time_tracking_app/core/config/navigator_key.dart';
import 'package:time_tracking_app/core/functions/common_functions.dart';
import 'package:time_tracking_app/core/functions/custom_bloc_validators.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/presentation/widgets/loading_dialog.dart';
import 'package:time_tracking_app/data/model/multi_data.dart';
import 'package:time_tracking_app/data/model/task.dart';
import 'package:time_tracking_app/domain/usecases/task_usecase.dart';

class AddEditTaskFormBloc extends FormBloc<String, String> {
  final priorityMap = {
    1: 'Low',
    2: 'Normal',
    3: 'High',
    4: 'Critical',
  };
  final tfTaskContent =
      TextFieldBloc(validators: [CustomBlocValidators.requiredTaskContent]);
  final tfTaskDescription =
      TextFieldBloc(validators: [CustomBlocValidators.requiredTaskDescription]);
  final tfTProjectId = TextFieldBloc(initialValue: '2337659677');
  final tfTaskId = TextFieldBloc();
  final selectPriority = SelectFieldBloc<MultiData, dynamic>(items: [
    MultiData(id: '1', description: 'Low'),
    MultiData(id: '2', description: 'Normal'),
    MultiData(id: '3', description: 'High'),
    MultiData(id: '4', description: 'Critical'),
  ], validators: [
    CustomBlocValidators.requiredPriority
  ]);
  final dueDateTime = InputFieldBloc<DateTime?, Object>(initialValue: null);
  final tfDurationInMinutes = TextFieldBloc();
  final boolIsEditMode = BooleanFieldBloc(initialValue: false);

  AddEditTaskFormBloc()
      : super(
          isLoading: true,
        ) {
    addFieldBlocs(fieldBlocs: [
      tfTaskContent,
      tfTaskDescription,
      tfTProjectId,
      tfTaskId,
      selectPriority,
      dueDateTime,
      tfDurationInMinutes,
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

      final response = await Injector.resolve<TaskUseCase>()
          .getTasksById(taskId: tfTaskId.value);

      final task = Task.fromJson(response);

      if (task.content != null) {
        tfTaskContent.updateValue(task.content!);
      }

      if (task.description != null) {
        tfTaskDescription.updateValue(task.description!);
      }

      if (task.duration != null) {
        tfDurationInMinutes.updateValue(task.duration!);
      }

      if (task.priority != null) {
        selectPriority.updateValue(MultiData(
            id: task.priority.toString(),
            description: priorityMap[task.priority!].toString()));
      }

      if (task.due?.date != null) {
        dueDateTime.updateValue(DateTime.parse(task.due!.date!));
      }

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
        'content': tfTaskContent.value,
        'description': tfTaskDescription.value,
      };

      if (!boolIsEditMode.value) {
        inputData.addAll({'project_id': tfTProjectId.value});
      }

      if (selectPriority.value != null) {
        inputData.addAll({'priority': selectPriority.value?.id});
      }

      if (tfDurationInMinutes.value.isNotEmpty) {
        inputData
            .addAll({'amount': tfDurationInMinutes.value, 'unit': 'minute'});
      }

      if (dueDateTime.value != null) {
        final dueDateParams = {
          "datetime":
              CommonFunctions.formatToRFC3339NanoUtc(dueDateTime.value!),
          "timezone": "UTC±05:30"
        };
        inputData.addAll({
          'due': dueDateParams,
        });
      }

      if (boolIsEditMode.value) {
        await Injector.resolve<TaskUseCase>().updateTask(
          inputData: inputData,
          taskId: tfTaskId.value,
        );
      } else {
        await Injector.resolve<TaskUseCase>().createTask(
          inputData: inputData,
        );
      }

      final message =
          'Task ${boolIsEditMode.value ? 'updated' : 'added'} successfully!';
      emitSuccess(successResponse: message);
    } catch (e) {
      emitFailure(failureResponse: '$e');
    }
  }
}
