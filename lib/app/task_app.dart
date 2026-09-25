import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/storage/theme_preferences.dart';
import '../core/theme/app_theme.dart';
import '../cubit/task_cubit.dart';
import '../data/repositories/task_repository.dart';
import '../features/tasks/presentation/screens/home_screen.dart';

class TaskApp extends StatefulWidget {
  const TaskApp({
    super.key,
    required this.repository,
    required this.themePreferences,
  });

  final TaskRepository repository;
  final ThemePreferences themePreferences;

  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  late ThemeMode _themeMode;
  int _themeWriteVersion = 0;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themePreferences.read();
  }

  Future<void> _toggleTheme() async {
    final previousMode = _themeMode;
    final nextMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    final writeVersion = ++_themeWriteVersion;
    setState(() => _themeMode = nextMode);
    try {
      final saved = await widget.themePreferences.write(nextMode);
      if (!mounted || writeVersion != _themeWriteVersion) {
        return;
      }
      if (!saved) {
        setState(() => _themeMode = previousMode);
      }
    } on Object {
      if (mounted && writeVersion == _themeWriteVersion) {
        setState(() => _themeMode = previousMode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskCubit(widget.repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TaskFlow',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        themeAnimationDuration: AppMotion.standard,
        home: TaskDashboardScreen(
          onThemeToggle: _toggleTheme,
          isDarkMode: _themeMode == ThemeMode.dark,
        ),
      ),
    );
  }
}
