import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../models/task_model.dart';

Future<void> showTaskDetailsDialog(BuildContext context, TaskModel task) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) {
      final theme = Theme.of(dialogContext);
      final scheme = theme.colorScheme;
      final dueBadge = _buildDueBadge(task);

      return AlertDialog(
        title: const Text('Task details'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.detailsMaxWidth,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title, style: theme.textTheme.titleLarge),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: [
                    StatusBadge(
                      label: task.isCompleted ? 'Completed' : 'Pending',
                      tone: task.isCompleted
                          ? StatusBadgeTone.success
                          : StatusBadgeTone.primary,
                      icon: task.isCompleted
                          ? Icons.check_circle_outline
                          : Icons.pending_actions_outlined,
                    ),
                    dueBadge,
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Divider(
                  height: AppDimensions.dividerThickness,
                  color: scheme.outlineVariant,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Description',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  task.description.isEmpty
                      ? 'No description was added to this task.'
                      : task.description,
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Created ${AppDateFormatter.format(task.createdAt)}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.of(dialogContext).pop(),
            icon: const Icon(Icons.close_rounded),
            label: const Text('Close'),
          ),
        ],
      );
    },
  );
}

StatusBadge _buildDueBadge(TaskModel task) {
  if (task.dueDate == null) {
    return const StatusBadge(
      label: 'No due date',
      tone: StatusBadgeTone.neutral,
      icon: Icons.calendar_month_outlined,
    );
  }
  if (AppDateFormatter.isPast(task.dueDate!)) {
    return StatusBadge(
      label: 'Overdue · ${AppDateFormatter.format(task.dueDate!)}',
      tone: StatusBadgeTone.error,
    );
  }
  if (AppDateFormatter.isToday(task.dueDate!)) {
    return StatusBadge(
      label: 'Due today · ${AppDateFormatter.format(task.dueDate!)}',
      tone: StatusBadgeTone.warning,
    );
  }
  return StatusBadge(
    label: 'Due · ${AppDateFormatter.format(task.dueDate!)}',
    tone: StatusBadgeTone.info,
  );
}
