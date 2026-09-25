import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppSurface extends StatelessWidget {
  const AppSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.color,
    this.borderRadius,
    this.border,
    this.elevated = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? scheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadii.lg),
        border: border ?? Border.all(color: scheme.outlineVariant),
        boxShadow: elevated
            ? isDark
                  ? AppShadows.darkMedium
                  : AppShadows.lightMedium
            : null,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
