class CompletedItems {
  List<CompletedItem>? items;

  CompletedItems({this.items});

  CompletedItems.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <CompletedItem>[];
      json['items'].forEach((v) {
        items!.add(CompletedItem.fromJson(v));
      });
    }
  }
}

class CompletedItem {
  String? completedAt;
  String? content;
  String? id;
  String? itemObject;
  String? metaData;
  int? noteCount;
  List<String>? notes;
  String? projectId;
  String? sectionId;
  String? taskId;
  String? userId;
  String? v2ProjectId;
  String? v2SectionId;
  String? v2TaskId;

  CompletedItem(
      {this.completedAt,
      this.content,
      this.id,
      this.itemObject,
      this.metaData,
      this.noteCount,
      this.notes,
      this.projectId,
      this.sectionId,
      this.taskId,
      this.userId,
      this.v2ProjectId,
      this.v2SectionId,
      this.v2TaskId});

  CompletedItem.fromJson(Map<String, dynamic> json) {
    completedAt = json['completed_at'];
    content = json['content'];
    id = json['id'];
    itemObject = json['item_object'].toString();
    metaData = json['meta_data'].toString();
    noteCount = json['note_count'];
    if (json['notes'] != null) {
      notes = [];
      json['notes'].forEach((v) {
        notes!.add(v);
      });
    }
    projectId = json['project_id'];
    sectionId = json['section_id'];
    taskId = json['task_id'];
    userId = json['user_id'];
    v2ProjectId = json['v2_project_id'];
    v2SectionId = json['v2_section_id'];
    v2TaskId = json['v2_task_id'];
  }
}
