import 'package:hive/hive.dart';

import '../../models/task_model.dart';
import 'task_repository.dart';

class HiveTaskRepository implements TaskRepository {
  const HiveTaskRepository(this._taskBox);

  final Box<TaskModel> _taskBox;

  @override
  List<TaskModel> getTasks() {
    final tasks = _taskBox.values.toList()
      ..sort((first, second) => second.createdAt.compareTo(first.createdAt));
    return List<TaskModel>.unmodifiable(tasks);
  }

  @override
  Future<void> addTask(TaskModel task) {
    return _taskBox.put(task.id, task);
  }

  @override
  Future<void> updateTask(TaskModel task) {
    return _taskBox.put(task.id, task);
  }

  @override
  Future<void> deleteTask(String id) {
    return _taskBox.delete(id);
  }
}
