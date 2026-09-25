import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppMark extends StatelessWidget {
  const AppMark({super.key, this.size = AppDimensions.iconSizeXl});

  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadii.sm),
        boxShadow: Theme.of(context).brightness == Brightness.dark
            ? AppShadows.darkLow
            : AppShadows.lightLow,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.check_rounded,
            color: scheme.onPrimary,
            size: size * AppDimensions.logoMarkIconScale,
          ),
          Positioned(
            top: size * AppDimensions.logoMarkAccentInset,
            right: size * AppDimensions.logoMarkAccentInset,
            child: Container(
              width: size * AppDimensions.logoMarkAccentScale,
              height: size * AppDimensions.logoMarkAccentScale,
              decoration: BoxDecoration(
                color: scheme.secondary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
