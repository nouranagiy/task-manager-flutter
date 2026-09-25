import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../cubit/task_cubit.dart';
import '../../../../cubit/task_state.dart';
import '../../../../models/task_model.dart';
import '../widgets/task_dashboard_view.dart';
import '../widgets/task_filter.dart';
import '../widgets/task_filter_navigation.dart';
import '../widgets/task_sidebar.dart';
import 'add_task_screen.dart';

class TaskDashboardScreen extends StatefulWidget {
  const TaskDashboardScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  @override
  State<TaskDashboardScreen> createState() => _TaskDashboardScreenState();
}

class _TaskDashboardScreenState extends State<TaskDashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  TaskFilter _selectedFilter = TaskFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _searchQuery = '');
  }

  void _resetView() {
    _clearSearch();
    setState(() => _selectedFilter = TaskFilter.all);
  }

  void _openCreate() {
    Navigator.of(
      context,
    ).push<void>(MaterialPageRoute(builder: (_) => const AddTaskScreen()));
  }

  void _openEdit(TaskModel task) {
    Navigator.of(
      context,
    ).push<void>(MaterialPageRoute(builder: (_) => AddTaskScreen(task: task)));
  }

  Future<void> _confirmDelete(TaskModel task) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final scheme = Theme.of(dialogContext).colorScheme;
        return AlertDialog(
          icon: const Icon(Icons.delete_outline_rounded),
          title: const Text('Delete task?'),
          content: const Text('This task will be removed permanently.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: scheme.error,
                foregroundColor: scheme.onError,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
    if (shouldDelete == true && mounted) {
      unawaited(context.read<TaskCubit>().deleteTask(task.id));
    }
  }

  void _toggleTask(TaskModel task) {
    unawaited(context.read<TaskCubit>().toggleTask(task));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage &&
          current.errorMessage != null,
      listener: (context, state) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      },
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isWide =
                  constraints.maxWidth >= AppDimensions.tabletBreakpoint;
              final completedCount = state.tasks
                  .where((task) => task.isCompleted)
                  .length;
              final pendingCount = state.tasks.length - completedCount;
              final query = _searchQuery.trim().toLowerCase();
              final visibleTasks = state.tasks
                  .where((task) {
                    final matchesSearch =
                        query.isEmpty ||
                        task.title.toLowerCase().contains(query) ||
                        task.description.toLowerCase().contains(query);
                    final matchesFilter = switch (_selectedFilter) {
                      TaskFilter.all => true,
                      TaskFilter.pending => !task.isCompleted,
                      TaskFilter.completed => task.isCompleted,
                    };
                    return matchesSearch && matchesFilter;
                  })
                  .toList(growable: false);

              return Scaffold(
                body: SafeArea(
                  child: Row(
                    children: [
                      if (isWide)
                        TaskSidebar(
                          selectedFilter: _selectedFilter,
                          allCount: state.tasks.length,
                          pendingCount: pendingCount,
                          completedCount: completedCount,
                          isDarkMode: widget.isDarkMode,
                          onFilterChanged: (filter) {
                            setState(() => _selectedFilter = filter);
                          },
                          onThemeToggle: widget.onThemeToggle,
                        ),
                      Expanded(
                        child: TaskDashboardView(
                          visibleTasks: visibleTasks,
                          totalCount: state.tasks.length,
                          completedCount: completedCount,
                          pendingCount: pendingCount,
                          selectedFilter: _selectedFilter,
                          searchController: _searchController,
                          searchQuery: _searchQuery,
                          isLoading: state.isLoading,
                          hasError:
                              state.errorMessage != null && state.tasks.isEmpty,
                          isDarkMode: widget.isDarkMode,
                          isWide: isWide,
                          onThemeToggle: widget.onThemeToggle,
                          onSearchChanged: (query) {
                            setState(() => _searchQuery = query);
                          },
                          onClearSearch: _clearSearch,
                          onCreate: _openCreate,
                          onResetView: _resetView,
                          onRetry: () {
                            unawaited(context.read<TaskCubit>().loadTasks());
                          },
                          onToggle: _toggleTask,
                          onEdit: _openEdit,
                          onDelete: (task) {
                            unawaited(_confirmDelete(task));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: isWide
                    ? null
                    : TaskFilterNavigationBar(
                        selectedFilter: _selectedFilter,
                        allCount: state.tasks.length,
                        pendingCount: pendingCount,
                        completedCount: completedCount,
                        onFilterChanged: (filter) {
                          setState(() => _selectedFilter = filter);
                        },
                      ),
                floatingActionButton: isWide
                    ? FloatingActionButton.extended(
                        onPressed: _openCreate,
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('New task'),
                      )
                    : FloatingActionButton(
                        onPressed: _openCreate,
                        tooltip: 'Create task',
                        child: const Icon(Icons.add_rounded),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
