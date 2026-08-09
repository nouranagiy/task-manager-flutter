import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/task_repository.dart';
import '../models/task_model.dart';
class TaskCubit extends Cubit<List<TaskModel>> {
  final TaskRepository repository;
  TaskCubit(this.repository) : super([]) {
    loadTasks();
  }
  void loadTasks() {
    final tasks = repository.getTasks();
    emit(tasks);
  }
  Future<void> addTask(TaskModel task) async {
    await repository.addTask(task);
    loadTasks();
  }
  Future<void> updateTask(TaskModel task) async {
    await repository.updateTask(task);
    loadTasks();
  }
  Future<void> deleteTask(String id) async {
    await repository.deleteTask(id);
    loadTasks();
  }
}