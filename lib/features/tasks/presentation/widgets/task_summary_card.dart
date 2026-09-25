import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_surface.dart';
import '../../../../core/widgets/status_badge.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({
    super.key,
    required this.total,
    required this.completed,
    required this.pending,
  });

  final int total;
  final int completed;
  final int pending;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final progress = total == 0 ? 0.0 : completed / total;

    return AppSurface(
      elevated: true,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StatusBadge(
                label: total == 0 ? 'Ready when you are' : 'Your momentum',
                tone: total == 0
                    ? StatusBadgeTone.info
                    : StatusBadgeTone.success,
                icon: total == 0
                    ? Icons.waving_hand_outlined
                    : Icons.auto_awesome_outlined,
              ),
              const Spacer(),
              Text(
                total == 0 ? 'No tasks yet' : '$completed of $total complete',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: _SummaryMetric(
                  label: 'All tasks',
                  value: total,
                  icon: Icons.inbox_outlined,
                  color: scheme.primary,
                  background: scheme.primaryContainer,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _SummaryMetric(
                  label: 'Pending',
                  value: pending,
                  icon: Icons.schedule_outlined,
                  color: scheme.secondary,
                  background: scheme.secondaryContainer,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _SummaryMetric(
                  label: 'Completed',
                  value: completed,
                  icon: Icons.check_circle_outline,
                  color: scheme.tertiary,
                  background: scheme.tertiaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Text('Progress', style: theme.textTheme.labelMedium),
              const Spacer(),
              Text(
                '${(progress * 100).round()}%',
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: AppDimensions.progressHeight,
              backgroundColor: scheme.surfaceContainerHigh,
              color: scheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.background,
  });

  final String label;
  final int value;
  final IconData icon;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppDimensions.minTouchTarget,
          height: AppDimensions.minTouchTarget,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          child: Icon(icon, color: color, size: AppDimensions.iconSizeMd),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(value.toString(), style: theme.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.xxs),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
