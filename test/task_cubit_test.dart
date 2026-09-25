import 'package:flutter_test/flutter_test.dart';

import 'package:task1/cubit/task_cubit.dart';
import 'package:task1/cubit/task_state.dart';
import 'package:task1/data/repositories/task_repository.dart';
import 'package:task1/models/task_model.dart';

class _MemoryTaskRepository implements TaskRepository {
  _MemoryTaskRepository([List<TaskModel>? initialTasks])
    : _tasks = [...?initialTasks];

  final List<TaskModel> _tasks;
  bool failReads = false;

  @override
  Future<void> addTask(TaskModel task) async {
    _tasks.add(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
  }

  @override
  List<TaskModel> getTasks() {
    if (failReads) {
      throw StateError('read failed');
    }
    return List.unmodifiable(_tasks);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) {
      _tasks.add(task);
    } else {
      _tasks[index] = task;
    }
  }
}

TaskModel _task({String id = 'task-1', bool isCompleted = false}) {
  return TaskModel(
    id: id,
    title: 'Task $id',
    description: 'Description',
    createdAt: DateTime(2026, 9, 25),
    isCompleted: isCompleted,
  );
}

void main() {
  test('loads and mutates tasks through the repository', () async {
    final repository = _MemoryTaskRepository([_task()]);
    final cubit = TaskCubit(repository);

    await cubit.loadTasks();
    expect(cubit.state.status, TaskStatus.success);
    expect(cubit.state.tasks, hasLength(1));

    final updated = cubit.state.tasks.single.copyWith(isCompleted: true);
    expect(await cubit.updateTask(updated), isTrue);
    expect(cubit.state.tasks.single.isCompleted, isTrue);

    await cubit.close();
  });

  test('exposes a failure state when the repository cannot read', () async {
    final repository = _MemoryTaskRepository()..failReads = true;
    final cubit = TaskCubit(repository);

    await cubit.loadTasks();

    expect(cubit.state.status, TaskStatus.failure);
    expect(cubit.state.errorMessage, isNotNull);

    await cubit.close();
  });
}
