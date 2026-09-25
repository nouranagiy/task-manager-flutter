import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class TaskPageHeader extends StatelessWidget {
  const TaskPageHeader({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.showThemeToggle,
  });

  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final bool showThemeToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('YOUR WORKSPACE', style: theme.textTheme.labelSmall),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Stay on top of your day.',
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'A clear view of what needs your attention next.',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        if (showThemeToggle) ...[
          const SizedBox(width: AppSpacing.md),
          IconButton(
            onPressed: onThemeToggle,
            tooltip: isDarkMode
                ? 'Switch to light mode'
                : 'Switch to dark mode',
            style: IconButton.styleFrom(
              backgroundColor: scheme.surface,
              side: BorderSide(color: scheme.outlineVariant),
            ),
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ],
    );
  }
}
