import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/task_model.dart';
import 'data/local/task_adapter.dart';
import 'data/repositories/task_repository.dart';
import 'cubit/task_cubit.dart';
import 'screens/home_screen.dart';
import 'core/theme/app_theme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  final taskBox = await Hive.openBox<TaskModel>('tasks');
  final repository = TaskRepository(taskBox);
  final preferences = await SharedPreferences.getInstance();
  final isDarkMode = preferences.getBool('isDarkMode') ?? false;
  runApp(
    BlocProvider(
      create: (_) => TaskCubit(repository),
      child: MyApp(
        isDarkMode: isDarkMode,
      ),
    ),
  );
}
class MyApp extends StatefulWidget {
  final bool isDarkMode;
  const MyApp({
    super.key,
    required this.isDarkMode,
  });
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;
  late SharedPreferences _preferences;
  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _loadPreferences();
  }
  Future<void> _loadPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }
  Future<void> _toggleTheme() async {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    await _preferences.setBool(
      'isDarkMode',
      _isDarkMode,
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(
        onThemeToggle: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}