import '../models/task_model.dart';

enum TaskStatus { initial, loading, success, failure }

class TaskState {
  const TaskState({
    this.status = TaskStatus.initial,
    this.tasks = const <TaskModel>[],
    this.errorMessage,
  });

  final TaskStatus status;
  final List<TaskModel> tasks;
  final String? errorMessage;

  bool get isLoading => status == TaskStatus.loading;

  TaskState copyWith({
    TaskStatus? status,
    List<TaskModel>? tasks,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
