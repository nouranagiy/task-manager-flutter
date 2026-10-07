import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/app_surface.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../models/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    required this.onViewDetails,
  });

  final TaskModel task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onViewDetails;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final dueBadge = _buildDueBadge();

    return Semantics(
      container: true,
      label: '${task.title}, ${task.isCompleted ? 'completed' : 'pending'}',
      child: AppSurface(
        elevated: true,
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AppDimensions.minTouchTarget,
              height: AppDimensions.minTouchTarget,
              child: Center(
                child: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) => onToggle(),
                  semanticLabel: task.isCompleted
                      ? 'Mark ${task.title} as pending'
                      : 'Mark ${task.title} as completed',
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: task.isCompleted
                          ? scheme.onSurfaceVariant
                          : scheme.onSurface,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  if (task.description.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      task.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton.icon(
                      onPressed: onViewDetails,
                      icon: const Icon(
                        Icons.notes_rounded,
                        size: AppDimensions.iconSizeSm,
                      ),
                      label: const Text('View details'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(
                          0,
                          AppDimensions.compactButtonHeight,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: [dueBadge],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            PopupMenuButton<_TaskMenuAction>(
              tooltip: 'Task actions',
              onSelected: (action) {
                switch (action) {
                  case _TaskMenuAction.details:
                    onViewDetails();
                  case _TaskMenuAction.edit:
                    onEdit();
                  case _TaskMenuAction.delete:
                    onDelete();
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: _TaskMenuAction.details,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.visibility_outlined),
                    title: Text('View details'),
                  ),
                ),
                PopupMenuItem(
                  value: _TaskMenuAction.edit,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.edit_outlined),
                    title: Text('Edit task'),
                  ),
                ),
                PopupMenuItem(
                  value: _TaskMenuAction.delete,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.delete_outline),
                    title: Text('Delete task'),
                  ),
                ),
              ],
              icon: const Icon(Icons.more_horiz_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDueBadge() {
    if (task.isCompleted) {
      return const StatusBadge(
        label: 'Completed',
        tone: StatusBadgeTone.success,
        icon: Icons.check_circle_outline,
      );
    }
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
}

enum _TaskMenuAction { details, edit, delete }
