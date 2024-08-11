import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:time_tracking_app/core/functions/custom_bloc_validators.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/data/model/multi_data.dart';
import 'package:time_tracking_app/domain/usecases/task_usecase.dart';

class AddEditTaskFormBloc extends FormBloc<String, String> {
  final tfTaskContent =
      TextFieldBloc(validators: [CustomBlocValidators.requiredTaskContext]);
  final tfTaskDescription =
      TextFieldBloc(validators: [CustomBlocValidators.requiredTaskDescription]);
  final tfTProjectId = TextFieldBloc(initialValue: '2337659677');
  final tfTSectionId = TextFieldBloc();
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

  AddEditTaskFormBloc() : super() {
    addFieldBlocs(fieldBlocs: [
      tfTaskContent,
      tfTaskDescription,
      tfTProjectId,
      tfTSectionId,
      tfTaskId,
      selectPriority,
      dueDateTime,
      tfDurationInHours,
    ]);
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
        inputData.addAll({
          'project_id': tfTProjectId.value,
          'section_id': tfTSectionId.value,
        });
      }

      if (selectPriority.value != null) {
        inputData.addAll({'priority': selectPriority.value?.id});
      }


      if (tfDurationInHours.value.isNotEmpty) {
        inputData.addAll({'duration':  tfDurationInHours.value });
      }

      if (dueDateTime.value != null) {
        print(dueDateTime.value?.toIso8601String());
        inputData.addAll({'dueDateTime':  '${dueDateTime.value?.toIso8601String()}000Z' });
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
