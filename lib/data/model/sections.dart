class Sections {
  String? id;
  String? projectId;
  int? order;
  String? name;

  Sections({this.id, this.projectId, this.order, this.name});

  factory Sections.fromJson(Map<String, dynamic> json) {
    return Sections(
      id: json['id'],
      projectId: json['project_id'],
      order: json['order'],
      name: json['name'],
    );
  }
}
