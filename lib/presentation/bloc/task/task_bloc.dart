import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/enums/bloc_states.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/data/model/completed_items.dart';
import 'package:time_tracking_app/data/model/task.dart';
import 'package:time_tracking_app/domain/usecases/task_usecase.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TasksLoadingState()) {
    on<TaskEvent>(_init);
  }

  void _init(TaskEvent event, Emitter<TaskState> emit) async {
    emit(TasksLoadingState());

    if (event is GetTasksByProjectAndSectionEvent) {
      try {
        dynamic response =
            await Injector.resolve<TaskUseCase>().getTasksByProjectAndSection(
          projectId: event.projectId,
          sectionId: event.sectionId,
        );

        final tasks =
            (response as List).map((task) => Task.fromJson(task)).toList();

        emit(TasksLoadedState(
          taskTodoList: tasks,
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
