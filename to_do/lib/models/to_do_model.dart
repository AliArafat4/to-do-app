class ToDo {
  final String? title;
  final String? description;
  bool? completed;
  // final int? userId;
  final int id;
  final String? createdAt;

  ToDo({
    required this.title,
    required this.description,
    required this.completed,
    required this.id,
    required this.createdAt,
  });

  factory ToDo.fromJson(Map json) {
    return ToDo(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      completed: json["completed"],
      createdAt: json["created_at"],
    );
  }
}
