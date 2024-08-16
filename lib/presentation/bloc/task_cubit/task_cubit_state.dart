part of 'task_cubit.dart';

abstract class TaskCubitState {}

class TaskCubitLoadedState extends TaskCubitState {
  final List<Task> tasksList;

  TaskCubitLoadedState({required this.tasksList});
}
