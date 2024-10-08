class Comment {
  String? id;
  String? taskId;
  String? content;
  String? postedAt;

  Comment({
    this.id,
    this.taskId,
    this.content,
    this.postedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        taskId: json['task_id'],
        content: json['content'],
        postedAt: json['posted_at'],
      );
}
