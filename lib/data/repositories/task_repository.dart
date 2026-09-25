import '../../models/task_model.dart';

abstract interface class TaskRepository {
  List<TaskModel> getTasks();

  Future<void> addTask(TaskModel task);

  Future<void> updateTask(TaskModel task);

  Future<void> deleteTask(String id);
}
