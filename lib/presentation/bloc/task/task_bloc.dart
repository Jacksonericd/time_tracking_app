import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/enums/bloc_states.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/data/model/task.dart';
import 'package:time_tracking_app/data/model/task_start_time.dart';
import 'package:time_tracking_app/domain/usecases/local_data_usecase.dart';
import 'package:time_tracking_app/domain/usecases/task_usecase.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TasksLoadingState()) {
    on<TaskEvent>(_init);
  }

  void _init(TaskEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoadingState());

    if (event is FilerTasksEvent) {
      final tasks = event.allTasks;

      try {
        dynamic localResponse =
            await Injector.resolve<LocalDataUseCase>().getAllTaskTimer();

        final allLocalTasks = (localResponse as List)
            .map((task) => TasksStartTime.fromJson(task))
            .toList();

        final ongoingTaskIds = allLocalTasks.map((item) {
          if (item.endTime == null) {
            return item.taskId;
          }
        }).toList();

        ongoingTaskIds.removeWhere((item) => item == null);

        final completedTaskIds = allLocalTasks.map((item) {
          if (item.endTime != null) {
            return item.taskId;
          }
        }).toList();

        completedTaskIds.removeWhere((item) => item == null);

        final toDoListFiltered = tasks
            .where((item) =>
                !ongoingTaskIds.contains(item.id!) &&
                !completedTaskIds.contains(item.id!))
            .toList();

        final onGoingListFiltered =
            tasks.where((item) => ongoingTaskIds.contains(item.id!)).toList();

        final completedListFiltered =
            tasks.where((item) => completedTaskIds.contains(item.id!)).toList();

        emit(TasksLoadedState(
          taskTodoList: toDoListFiltered,
          taskOngoingList: onGoingListFiltered,
          taskCompList: completedListFiltered,
        ));
      } catch (e) {
        emit(TasksErrorState(error: '$e'));
      }
    }

    if (event is GetTasksByProjectEvent) {
      try {
        dynamic response =
            await Injector.resolve<TaskUseCase>().getTasksByProjectId(
          projectId: event.projectId,
        );

        final tasks =
            (response as List).map((task) => Task.fromJson(task)).toList();

        dynamic localResponse =
            await Injector.resolve<LocalDataUseCase>().getAllTaskTimer();

        final allLocalTasks = (localResponse as List)
            .map((task) => TasksStartTime.fromJson(task))
            .toList();

        print('allLocalTasks : ${allLocalTasks.length}');

        final ongoingTaskIds = allLocalTasks.map((item) {
          if (item.endTime == null) {
            return item.taskId;
          }
        }).toList();

        ongoingTaskIds.removeWhere((item) => item == null);
        print('ongoingTaskIds : ${ongoingTaskIds.length}');

        final completedTaskIds = allLocalTasks.map((item) {
          if (item.endTime != null) {
            return item.taskId;
          }
        }).toList();

        completedTaskIds.removeWhere((item) => item == null);
        print('completedTaskIds : ${completedTaskIds.length}');

        final toDoListFiltered = tasks
            .where((item) =>
                !ongoingTaskIds.contains(item.id!) &&
                !completedTaskIds.contains(item.id!))
            .toList();

        final onGoingListFiltered =
            tasks.where((item) => ongoingTaskIds.contains(item.id!)).toList();

        final completedListFiltered =
            tasks.where((item) => completedTaskIds.contains(item.id!)).toList();

        // dynamic completedResponse =
        //     await Injector.resolve<TaskUseCase>().getCompletedTasksByProject(
        //   projectId: event.projectId,
        // );
        //
        // final completed = CompletedItems.fromJson(completedResponse);

        emit(TasksLoadedState(
          taskTodoList: toDoListFiltered,
          taskOngoingList: onGoingListFiltered,
          taskCompList: completedListFiltered,
          // taskCompletedList: completed.items,
        ));
      } catch (e) {
        if (e is DioException) {
          emit(TasksErrorState(error: '${e.error}'));
          return;
        }
        emit(TasksErrorState(error: '$e'));
      }
    }
  }
}
