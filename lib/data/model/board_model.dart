import 'package:time_tracking_app/data/model/task.dart';

class BoardListModel {
  // int count;
  List<Task> items;
  String name;

  BoardListModel({
    // required this.count,
    required this.name,
    required this.items,
  });
}
