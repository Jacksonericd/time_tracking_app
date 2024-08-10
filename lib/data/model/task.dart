class Task {
  String? id;
  String? assignerId;
  String? assigneeId;
  String? projectId;
  String? sectionId;
  String? parentId;
  int? order;
  String? content;
  String? description;
  bool? isCompleted;
  List<String>? labels;
  int? priority;
  int? commentCount;
  String? creatorId;
  String? createdAt;
  Due? due;
  String? url;
  String? duration;

  Task(
      {this.id,
      this.assignerId,
      this.assigneeId,
      this.projectId,
      this.sectionId,
      this.parentId,
      this.order,
      this.content,
      this.description,
      this.isCompleted,
      this.labels,
      this.priority,
      this.commentCount,
      this.creatorId,
      this.createdAt,
      this.due,
      this.url,
      this.duration});

  factory Task.fromJson(Map<String, dynamic> json) {
    List<String> labels = [];
    if (json['labels'] != null) {
      json['labels'].forEach((v) {
        labels.add(v);
      });
    }

    return Task(
      id: json['id'],
      assignerId: json['assigner_id'].toString(),
      assigneeId: json['assignee_id'].toString(),
      projectId: json['project_id'],
      sectionId: json['section_id'],
      parentId: json['parent_id'].toString(),
      order: json['order'],
      content: json['content'],
      description: json['description'],
      isCompleted: json['is_completed'],
      labels: labels,
      priority: json['priority'],
      commentCount: json['comment_count'],
      creatorId: json['creator_id'],
      createdAt: json['created_at'],
      due: json['due'] != null ? Due.fromJson(json['due']) : null,
      url: json['url'],
      duration: json['duration'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assigner_id'] = assignerId;
    data['assignee_id'] = assigneeId;
    data['project_id'] = projectId;
    data['section_id'] = sectionId;
    data['parent_id'] = parentId;
    data['order'] = order;
    data['content'] = content;
    data['description'] = description;
    data['is_completed'] = isCompleted;
    data['labels'] = labels;
    data['priority'] = priority;
    data['comment_count'] = commentCount;
    data['creator_id'] = creatorId;
    data['created_at'] = createdAt;
    if (due != null) {
      data['due'] = due!.toJson();
    }
    data['url'] = url;
    data['duration'] = duration;
    return data;
  }
}

class Due {
  String? date;
  String? string;
  String? lang;
  bool? isRecurring;
  String? datetime;

  Due({this.date, this.string, this.lang, this.isRecurring, this.datetime});

  factory Due.fromJson(Map<String, dynamic> json) {
    return Due(
      date: json['date'],
      string: json['string'],
      lang: json['lang'],
      isRecurring: json['is_recurring'],
      datetime: json['datetime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['string'] = string;
    data['lang'] = lang;
    data['is_recurring'] = isRecurring;
    data['datetime'] = datetime;
    return data;
  }
}
