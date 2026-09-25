import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import 'task_filter.dart';

class TaskFilterNavigationBar extends StatelessWidget {
  const TaskFilterNavigationBar({
    super.key,
    required this.selectedFilter,
    required this.allCount,
    required this.pendingCount,
    required this.completedCount,
    required this.onFilterChanged,
  });

  final TaskFilter selectedFilter;
  final int allCount;
  final int pendingCount;
  final int completedCount;
  final ValueChanged<TaskFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: TaskFilter.values.indexOf(selectedFilter),
      onDestinationSelected: (index) {
        onFilterChanged(TaskFilter.values[index]);
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.inbox_outlined),
          selectedIcon: const Icon(Icons.inbox_rounded),
          label: 'All $allCount',
        ),
        NavigationDestination(
          icon: const Icon(Icons.schedule_outlined),
          selectedIcon: const Icon(Icons.schedule_rounded),
          label: 'Pending $pendingCount',
        ),
        NavigationDestination(
          icon: const Icon(Icons.check_circle_outline),
          selectedIcon: const Icon(Icons.check_circle_rounded),
          label: 'Done $completedCount',
        ),
      ],
    );
  }
}

class TaskFilterNavItem extends StatelessWidget {
  const TaskFilterNavItem({
    super.key,
    required this.label,
    required this.count,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int count;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final foreground = selected
        ? scheme.onPrimaryContainer
        : scheme.onSurfaceVariant;

    return Material(
      color: selected ? scheme.primaryContainer : scheme.surface,
      borderRadius: BorderRadius.circular(AppRadii.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Icon(icon, color: foreground, size: AppDimensions.iconSizeMd),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: foreground,
                  ),
                ),
              ),
              Text(
                count.toString(),
                style: theme.textTheme.labelMedium?.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
