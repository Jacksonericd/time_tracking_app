import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/config/navigator_key.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/presentation/widgets/loading_dialog.dart';
import 'package:time_tracking_app/core/presentation/widgets/show_bottom_message.dart';
import 'package:time_tracking_app/data/model/task.dart';
import 'package:time_tracking_app/domain/usecases/task_usecase.dart';

part 'task_cubit_state.dart';

class TaskCubit extends Cubit<TaskCubitState> {
  TaskCubit() : super(TaskCubitLoadedState(tasksList: []));

  setListData(List<Task> tasks) {
    if (state is TaskCubitLoadedState) {
      emit(TaskCubitLoadedState(tasksList: tasks));
    }
  }

  List<Task> getListData() {
    if (state is TaskCubitLoadedState) {
      final data = state as TaskCubitLoadedState;
      return data.tasksList;
    }
    return [];
  }

  Future<void> setCubitDataFromApi() async {
    try {
      print('setCubitDataFromApi');

      const projectId = String.fromEnvironment('project_id');

      dynamic response =
          await Injector.resolve<TaskUseCase>().getTasksByProjectId(
        projectId: projectId,
      );

      print(response);

      final tasks =
          (response as List).map((task) => Task.fromJson(task)).toList();

      setListData(tasks);
    } catch (e) {
      if (e is DioException) {
        showBottomMessage(appNavigatorKey.currentContext!,
            message: '${e.error}');
        return;
      }
      showBottomMessage(appNavigatorKey.currentContext!, message: '$e');
    }
  }
}
