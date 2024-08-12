class TasksStartTime {
  int? id;
  String? taskId;
  String? startTime;

  TasksStartTime({this.id, this.taskId, this.startTime});

  TasksStartTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['task_id'];
    startTime = json['start_time'];
  }
}
