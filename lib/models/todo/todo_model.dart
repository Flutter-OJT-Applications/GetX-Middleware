
class TodoModel {
  int? id;
  int? userId;
  String title;
  String description;
  DateTime? createdAt;
  DateTime? updatedAt;

  TodoModel({
    this.id,
    this.userId,
    required this.title,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  TodoModel.empty()
      : title = '',
        description = '';

  set setId(id) => this.id = id;

  set setTitle(title) => this.title = title;

  set setDescription(description) => this.description = description;

  factory TodoModel.fromDB(Map<String, dynamic> data) {
    return TodoModel(
        id: data['id'],
        userId: data['user_id'],
        title: data['title'],
        description: data['description'],
        createdAt: DateTime.parse(data['created_at']),
        updatedAt: DateTime.parse(data['updated_at']));
  }

  Map<String, Object?> toObject() {
    return {
      "id": id,
      "title": title,
      "description": description,
      'user_id': userId
    };
  }

  @override
  String toString() {
    return "{id: $id, userId: $userId, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt}";
  }
}
