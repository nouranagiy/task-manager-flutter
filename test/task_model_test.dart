import 'package:flutter_test/flutter_test.dart';

import 'package:task1/models/task_model.dart';

void main() {
  test('normalizes due dates and preserves values through copyWith', () {
    final task = TaskModel(
      id: 'task-1',
      title: 'Plan the week',
      description: 'Write the outline',
      createdAt: DateTime(2026, 9, 25, 9),
      dueDate: DateTime(2026, 9, 30, 18, 45),
    );

    expect(task.dueDate, DateTime(2026, 9, 30));
    expect(task.copyWith(isCompleted: true).isCompleted, isTrue);
    expect(task.copyWith(clearDueDate: true).dueDate, isNull);
  });

  test('uses value equality for task updates', () {
    final createdAt = DateTime(2026, 9, 25);
    final first = TaskModel(
      id: 'task-1',
      title: 'Read',
      description: '',
      createdAt: createdAt,
    );
    final second = first.copyWith(title: 'Read again');

    expect(first, isNot(second));
    expect(first.copyWith(), first);
  });
}
