class Todo {
  String? id;
  String? title;
  String? description;
  bool isCompleted;
  String? createdAt;
  String? updatedAt;

  Todo({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    this.createdAt,
    this.updatedAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
