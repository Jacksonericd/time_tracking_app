class TasksStartTime {
  int? id;
  String? taskId;
  String? startTime;
  String? endTime;

  TasksStartTime({this.id, this.taskId, this.startTime, this.endTime});

  TasksStartTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['task_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
}
