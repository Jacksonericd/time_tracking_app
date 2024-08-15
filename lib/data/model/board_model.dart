import 'package:time_tracking_app/core/enums/task_type.dart';
import 'package:time_tracking_app/data/model/task.dart';

class BoardListModel {
  List<Task> items;
  String name;
  TaskType taskType;

  BoardListModel({
    required this.name,
    required this.items,
    required this.taskType,
  });
}
