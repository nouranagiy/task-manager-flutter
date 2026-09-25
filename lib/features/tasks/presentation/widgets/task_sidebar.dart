import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_mark.dart';
import '../../../../core/widgets/app_surface.dart';
import 'task_filter.dart';
import 'task_filter_navigation.dart';

class TaskSidebar extends StatelessWidget {
  const TaskSidebar({
    super.key,
    required this.selectedFilter,
    required this.allCount,
    required this.pendingCount,
    required this.completedCount,
    required this.isDarkMode,
    required this.onFilterChanged,
    required this.onThemeToggle,
  });

  final TaskFilter selectedFilter;
  final int allCount;
  final int pendingCount;
  final int completedCount;
  final bool isDarkMode;
  final ValueChanged<TaskFilter> onFilterChanged;
  final VoidCallback onThemeToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final completionRate = allCount == 0 ? 0.0 : completedCount / allCount;

    return Container(
      width: AppDimensions.sidebarWidth,
      color: scheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const AppMark(),
                const SizedBox(width: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TaskFlow', style: theme.textTheme.titleMedium),
                    Text(
                      'Personal workspace',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxxl),
            Text('WORKSPACE', style: theme.textTheme.labelSmall),
            const SizedBox(height: AppSpacing.xs),
            TaskFilterNavItem(
              label: 'All tasks',
              count: allCount,
              icon: Icons.inbox_outlined,
              selected: selectedFilter == TaskFilter.all,
              onTap: () => onFilterChanged(TaskFilter.all),
            ),
            const SizedBox(height: AppSpacing.xxs),
            TaskFilterNavItem(
              label: 'Pending',
              count: pendingCount,
              icon: Icons.schedule_outlined,
              selected: selectedFilter == TaskFilter.pending,
              onTap: () => onFilterChanged(TaskFilter.pending),
            ),
            const SizedBox(height: AppSpacing.xxs),
            TaskFilterNavItem(
              label: 'Completed',
              count: completedCount,
              icon: Icons.check_circle_outline,
              selected: selectedFilter == TaskFilter.completed,
              onTap: () => onFilterChanged(TaskFilter.completed),
            ),
            const Spacer(),
            AppSurface(
              color: scheme.secondaryContainer,
              border: Border.all(color: scheme.secondaryContainer),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.insights_rounded,
                        size: AppDimensions.iconSizeMd,
                        color: scheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          'Your progress',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: scheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    completionRate == 0
                        ? 'Start with one small win.'
                        : '${(completionRate * 100).round()}% complete',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                    child: LinearProgressIndicator(
                      value: completionRate,
                      minHeight: AppDimensions.progressHeight,
                      backgroundColor: scheme.surface,
                      color: scheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                CircleAvatar(
                  radius: AppDimensions.avatarSize / 2,
                  backgroundColor: scheme.primaryContainer,
                  foregroundColor: scheme.onPrimaryContainer,
                  child: const Icon(Icons.person_outline_rounded),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('My workspace', style: theme.textTheme.titleSmall),
                      Text('Local & private', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onThemeToggle,
                  tooltip: isDarkMode
                      ? 'Switch to light mode'
                      : 'Switch to dark mode',
                  icon: Icon(
                    isDarkMode
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
