import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/task_app.dart';
import 'core/storage/theme_preferences.dart';
import 'data/local/task_adapter.dart';
import 'data/repositories/hive_task_repository.dart';
import 'models/task_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TaskAdapter());
  }
  final taskBox = await Hive.openBox<TaskModel>('tasks');
  final preferences = await SharedPreferences.getInstance();

  runApp(
    TaskApp(
      repository: HiveTaskRepository(taskBox),
      themePreferences: ThemePreferences(preferences),
    ),
  );
}
