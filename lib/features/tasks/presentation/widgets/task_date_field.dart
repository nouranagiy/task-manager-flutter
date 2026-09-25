import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';

class TaskDateField extends StatelessWidget {
  const TaskDateField({
    super.key,
    required this.dueDate,
    required this.onSelect,
    required this.onClear,
  });

  final DateTime? dueDate;
  final VoidCallback onSelect;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasDate = dueDate != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Due date', style: theme.textTheme.titleSmall),
            const SizedBox(width: AppSpacing.xs),
            Text('Optional', style: theme.textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Semantics(
          button: true,
          label: hasDate ? 'Edit due date' : 'Select due date',
          child: Material(
            color: scheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm),
              side: BorderSide(color: scheme.outlineVariant),
            ),
            child: InkWell(
              onTap: onSelect,
              borderRadius: BorderRadius.circular(AppRadii.sm),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: scheme.primary,
                      size: AppDimensions.iconSizeMd,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        hasDate
                            ? AppDateFormatter.format(dueDate!)
                            : 'Select a due date',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: hasDate
                              ? scheme.onSurface
                              : scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    if (hasDate)
                      IconButton(
                        onPressed: onClear,
                        tooltip: 'Clear due date',
                        icon: const Icon(Icons.close_rounded),
                      ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: scheme.onSurfaceVariant,
                      size: AppDimensions.iconSizeMd,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
