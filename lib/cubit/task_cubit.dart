import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/task_repository.dart';
import '../models/task_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this._repository) : super(const TaskState()) {
    loadTasks();
  }

  final TaskRepository _repository;

  Future<void> loadTasks() async {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(status: TaskStatus.loading, clearError: true));
    try {
      emit(
        state.copyWith(
          status: TaskStatus.success,
          tasks: _repository.getTasks(),
          clearError: true,
        ),
      );
    } on Object {
      if (!isClosed) {
        emit(
          state.copyWith(
            status: TaskStatus.failure,
            errorMessage: 'We could not load your tasks. Please try again.',
          ),
        );
      }
    }
  }

  Future<bool> addTask(TaskModel task) {
    return _performMutation(() => _repository.addTask(task));
  }

  Future<bool> updateTask(TaskModel task) {
    return _performMutation(() => _repository.updateTask(task));
  }

  Future<bool> deleteTask(String id) {
    return _performMutation(() => _repository.deleteTask(id));
  }

  Future<bool> toggleTask(TaskModel task) {
    return updateTask(task.copyWith(isCompleted: !task.isCompleted));
  }

  Future<bool> _performMutation(Future<void> Function() operation) async {
    if (isClosed) {
      return false;
    }
    try {
      await operation();
      if (isClosed) {
        return false;
      }
      emit(
        state.copyWith(
          status: TaskStatus.success,
          tasks: _repository.getTasks(),
          clearError: true,
        ),
      );
      return true;
    } on Object {
      if (!isClosed) {
        emit(
          state.copyWith(
            errorMessage: 'Something went wrong. Please try again.',
          ),
        );
      }
      return false;
    }
  }
}
