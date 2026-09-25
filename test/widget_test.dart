import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:task1/app/task_app.dart';
import 'package:task1/core/storage/theme_preferences.dart';
import 'package:task1/data/repositories/task_repository.dart';
import 'package:task1/models/task_model.dart';

class _MemoryTaskRepository implements TaskRepository {
  _MemoryTaskRepository([List<TaskModel>? initialTasks])
    : _tasks = [...?initialTasks];

  final List<TaskModel> _tasks;

  @override
  Future<void> addTask(TaskModel task) async {
    _tasks.add(task);
  }

  @override
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
  }

  @override
  List<TaskModel> getTasks() => List.unmodifiable(_tasks);

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

void main() {
  testWidgets('renders the task workspace and opens the create form', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final repository = _MemoryTaskRepository();

    await tester.pumpWidget(
      TaskApp(
        repository: repository,
        themePreferences: ThemePreferences(preferences),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Stay on top of your day.'), findsOneWidget);
    expect(find.text('Ready when you are'), findsOneWidget);

    await tester.tap(find.byTooltip('Create task'));
    await tester.pumpAndSettle();

    expect(find.text('Add task'), findsOneWidget);
    expect(find.text('Task title'), findsOneWidget);
  });
}
