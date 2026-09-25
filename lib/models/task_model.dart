class TaskModel {
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    DateTime? dueDate,
    this.isCompleted = false,
  }) : dueDate = dueDate == null
           ? null
           : DateTime(dueDate.year, dueDate.month, dueDate.day);

  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final bool isCompleted;

  static TaskModel create({
    required String title,
    required String description,
    DateTime? dueDate,
  }) {
    final now = DateTime.now();
    return TaskModel(
      id: now.microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: now,
      dueDate: dueDate,
    );
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? dueDate,
    bool clearDueDate = false,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      dueDate: clearDueDate ? null : dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TaskModel &&
            other.id == id &&
            other.title == title &&
            other.description == description &&
            other.createdAt == createdAt &&
            other.dueDate == dueDate &&
            other.isCompleted == isCompleted;
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, createdAt, dueDate, isCompleted);
}
