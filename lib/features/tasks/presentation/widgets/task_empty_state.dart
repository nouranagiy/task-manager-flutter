import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import 'task_filter.dart';

class TaskEmptyState extends StatelessWidget {
  const TaskEmptyState({
    super.key,
    required this.isSearching,
    required this.filter,
    required this.onCreate,
    required this.onReset,
  });

  final bool isSearching;
  final TaskFilter filter;
  final VoidCallback onCreate;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isFiltered = isSearching || filter != TaskFilter.all;
    final title = isSearching
        ? 'No tasks found'
        : filter == TaskFilter.completed
        ? 'Nothing completed yet'
        : filter == TaskFilter.pending
        ? 'You are all caught up'
        : 'Your list is clear';
    final subtitle = isSearching
        ? 'Try a different title or description.'
        : filter == TaskFilter.completed
        ? 'Completed tasks will appear here.'
        : filter == TaskFilter.pending
        ? 'Nice work. Enjoy the clear space.'
        : 'Add a task and turn intention into progress.';

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.emptyStateMaxWidth,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppDimensions.emptyStateIconSize,
                height: AppDimensions.emptyStateIconSize,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppRadii.xl),
                ),
                child: Icon(
                  isSearching
                      ? Icons.search_off_rounded
                      : Icons.task_alt_rounded,
                  color: scheme.onPrimaryContainer,
                  size: AppDimensions.iconSizeXl,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(title, style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              if (isFiltered)
                OutlinedButton.icon(
                  onPressed: onReset,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Reset view'),
                )
              else
                FilledButton.icon(
                  onPressed: onCreate,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Create a task'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
