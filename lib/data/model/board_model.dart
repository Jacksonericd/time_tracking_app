import 'package:time_tracking_app/core/enums/task_type.dart';
import 'package:time_tracking_app/data/model/task.dart';

class BoardListModel {
  // int count;
  List<Task> items;
  String name;
  TaskType taskType;

  BoardListModel({
    // required this.count,
    required this.name,
    required this.items,
    required this.taskType,
  });
}
