import 'package:flutter/material.dart';

class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'PlusJakartaSans';

  static TextTheme textTheme(ColorScheme scheme) {
    TextStyle style({
      required double size,
      required double height,
      required FontWeight weight,
      Color? color,
      double? letterSpacing,
    }) {
      return TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        height: height,
        fontWeight: weight,
        color: color ?? scheme.onSurface,
        letterSpacing: letterSpacing,
      );
    }

    return TextTheme(
      displayLarge: style(
        size: 32,
        height: 40 / 32,
        weight: FontWeight.w800,
        letterSpacing: -0.8,
      ),
      displayMedium: style(
        size: 28,
        height: 36 / 28,
        weight: FontWeight.w800,
        letterSpacing: -0.6,
      ),
      displaySmall: style(
        size: 24,
        height: 32 / 24,
        weight: FontWeight.w700,
        letterSpacing: -0.4,
      ),
      headlineLarge: style(
        size: 28,
        height: 36 / 28,
        weight: FontWeight.w800,
        letterSpacing: -0.6,
      ),
      headlineMedium: style(
        size: 24,
        height: 32 / 24,
        weight: FontWeight.w700,
        letterSpacing: -0.4,
      ),
      headlineSmall: style(
        size: 20,
        height: 28 / 20,
        weight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
      titleLarge: style(
        size: 20,
        height: 28 / 20,
        weight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
      titleMedium: style(size: 16, height: 24 / 16, weight: FontWeight.w600),
      titleSmall: style(size: 14, height: 20 / 14, weight: FontWeight.w600),
      bodyLarge: style(size: 16, height: 24 / 16, weight: FontWeight.w400),
      bodyMedium: style(
        size: 14,
        height: 20 / 14,
        weight: FontWeight.w400,
        color: scheme.onSurfaceVariant,
      ),
      bodySmall: style(
        size: 12,
        height: 16 / 12,
        weight: FontWeight.w400,
        color: scheme.onSurfaceVariant,
      ),
      labelLarge: style(size: 14, height: 20 / 14, weight: FontWeight.w600),
      labelMedium: style(
        size: 12,
        height: 16 / 12,
        weight: FontWeight.w600,
        color: scheme.onSurfaceVariant,
      ),
      labelSmall: style(
        size: 11,
        height: 16 / 11,
        weight: FontWeight.w600,
        color: scheme.onSurfaceVariant,
        letterSpacing: 0.2,
      ),
    );
  }
}
