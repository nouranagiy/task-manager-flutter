import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum StatusBadgeTone { success, warning, error, info, neutral, primary }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    this.tone = StatusBadgeTone.neutral,
    this.icon,
  });

  final String label;
  final StatusBadgeTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final semanticColors = theme.extension<AppSemanticColors>()!;
    final (background, foreground, iconData) = switch (tone) {
      StatusBadgeTone.success => (
        semanticColors.successContainer,
        semanticColors.onSuccessContainer,
        Icons.check_circle_outline,
      ),
      StatusBadgeTone.warning => (
        semanticColors.warningContainer,
        semanticColors.onWarningContainer,
        Icons.schedule_outlined,
      ),
      StatusBadgeTone.error => (
        semanticColors.errorContainer,
        semanticColors.onErrorContainer,
        Icons.error_outline,
      ),
      StatusBadgeTone.info => (
        semanticColors.infoContainer,
        semanticColors.onInfoContainer,
        Icons.info_outline,
      ),
      StatusBadgeTone.primary => (
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
        Icons.circle,
      ),
      StatusBadgeTone.neutral => (
        scheme.surfaceContainerHigh,
        scheme.onSurfaceVariant,
        Icons.circle,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon ?? iconData,
            size: AppDimensions.iconSizeXs,
            color: foreground,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(color: foreground),
          ),
        ],
      ),
    );
  }
}
