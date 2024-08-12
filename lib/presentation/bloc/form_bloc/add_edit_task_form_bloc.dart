import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:time_tracking_app/core/functions/custom_bloc_validators.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
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
  ]);
  final dueDateTime = InputFieldBloc<DateTime?, Object>(initialValue: null);
  final tfDurationInHours = TextFieldBloc();
  final boolIsEditMode = BooleanFieldBloc(initialValue: false);

  AddEditTaskFormBloc() : super(isLoading: true) {
    addFieldBlocs(fieldBlocs: [
      tfTaskContent,
      tfTaskDescription,
      tfTProjectId,
      tfTaskId,
      selectPriority,
      dueDateTime,
      tfDurationInHours,
    ]);
  }

  @override
  FutureOr<void> onLoading() async {
    try {
      if (!boolIsEditMode.value) {
        emitLoadFailed();
        return;
      }

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
        tfDurationInHours.updateValue(task.duration!);
      }

      if (task.priority != null) {
        selectPriority.updateValue(MultiData(
            id: task.priority.toString(),
            description: priorityMap[task.priority!].toString()));
      }

      if (task.due?.date != null) {
        // dueDateTime.updateValue(task.due?.date);
      }

      emitLoaded();
    } catch (e) {
      emitLoadFailed(failureResponse: '$e');
    }
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      final Map inputData = {
        'content': tfTaskContent.value,
        'description': tfTaskDescription.value,
        'duration_unit': 'Hours',
      };

      if (!boolIsEditMode.value) {
        inputData.addAll({'project_id': tfTProjectId.value});
      }

      if (selectPriority.value != null) {
        inputData.addAll({'priority': selectPriority.value?.id});
      }

      if (tfDurationInHours.value.isNotEmpty) {
        inputData.addAll({'duration': tfDurationInHours.value});
      }

      if (dueDateTime.value != null) {
        print(dueDateTime.value?.toIso8601String());
        inputData.addAll(
            {'dueDateTime': '${dueDateTime.value?.toIso8601String()}000Z'});
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
