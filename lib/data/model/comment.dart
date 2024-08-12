class Comment {
  String? id;
  String? taskId;
  String? projectId;
  String? content;
  String? postedAt;
  Attachment? attachment;

  Comment(
      {this.id,
      this.taskId,
      this.projectId,
      this.content,
      this.postedAt,
      this.attachment});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['task_id'];
    projectId = json['project_id'];
    content = json['content'];
    postedAt = json['posted_at'];
    attachment = json['attachment'] != null
        ? Attachment.fromJson(json['attachment'])
        : null;
  }
}

class Attachment {
  String? fileName;
  String? fileType;
  String? fileUrl;
  String? resourceType;

  Attachment({this.fileName, this.fileType, this.fileUrl, this.resourceType});

  Attachment.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
    fileType = json['file_type'];
    fileUrl = json['file_url'];
    resourceType = json['resource_type'];
  }
}
