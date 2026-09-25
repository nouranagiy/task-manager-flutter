import 'package:flutter/material.dart';

import 'design_tokens.dart';

export 'design_tokens.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme => _buildTheme(AppPalette.light);

  static ThemeData get darkTheme => _buildTheme(AppPalette.dark);

  static ThemeData _buildTheme(AppPalette palette) {
    final scheme = _colorScheme(palette);
    final textTheme = AppTypography.textTheme(scheme);
    final semanticColors = _semanticColors(palette);

    return ThemeData(
      useMaterial3: true,
      brightness: palette.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: palette.background,
      fontFamily: AppTypography.fontFamily,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[semanticColors],
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: textTheme.bodyMedium,
        labelStyle: textTheme.bodyMedium,
        prefixIconColor: scheme.onSurfaceVariant,
        suffixIconColor: scheme.onSurfaceVariant,
        border: _inputBorder(scheme.outlineVariant),
        enabledBorder: _inputBorder(scheme.outlineVariant),
        focusedBorder: _inputBorder(
          scheme.primary,
          width: AppDimensions.outlinedStrokeWidth,
        ),
        errorBorder: _inputBorder(scheme.error),
        focusedErrorBorder: _inputBorder(
          scheme.error,
          width: AppDimensions.outlinedStrokeWidth,
        ),
        errorStyle: textTheme.bodySmall?.copyWith(color: scheme.error),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
        shadowColor: palette.shadow,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: AppDimensions.dividerThickness,
        space: AppSpacing.md,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll<Size>(
            Size.fromHeight(AppDimensions.buttonHeight),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.sm,
            ),
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
          ),
          textStyle: WidgetStatePropertyAll<TextStyle>(textTheme.labelLarge!),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll<Size>(
            Size.fromHeight(AppDimensions.compactButtonHeight),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
          ),
          side: WidgetStatePropertyAll<BorderSide>(
            BorderSide(color: scheme.outline),
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
          ),
          textStyle: WidgetStatePropertyAll<TextStyle>(textTheme.labelLarge!),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(scheme.primary),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
          ),
          textStyle: WidgetStatePropertyAll<TextStyle>(textTheme.labelLarge!),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(
            scheme.onSurfaceVariant,
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.all(AppSpacing.sm),
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surface,
        selectedColor: scheme.primaryContainer,
        disabledColor: scheme.surfaceContainerHigh,
        side: BorderSide(color: scheme.outlineVariant),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        labelStyle: textTheme.labelMedium,
        secondaryLabelStyle: textTheme.labelMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        side: BorderSide(
          color: scheme.outline,
          width: AppDimensions.outlinedStrokeWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.xs),
        ),
        fillColor: WidgetStateProperty.resolveWith<Color?>(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.surface,
        ),
        checkColor: WidgetStatePropertyAll<Color>(scheme.onPrimary),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        elevation: 0,
        height: AppDimensions.minTouchTarget + AppSpacing.xl,
        labelTextStyle: WidgetStatePropertyAll<TextStyle>(
          textTheme.labelMedium!,
        ),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? scheme.onPrimaryContainer
                : scheme.onSurfaceVariant,
            size: AppDimensions.iconSizeMd,
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.xl),
        ),
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.xl),
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.primaryContainer,
        circularTrackColor: scheme.primaryContainer,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: BorderRadius.circular(AppRadii.xs),
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: scheme.onInverseSurface,
        ),
      ),
    );
  }

  static ColorScheme _colorScheme(AppPalette palette) {
    return ColorScheme.fromSeed(
      seedColor: palette.primary,
      brightness: palette.brightness,
    ).copyWith(
      primary: palette.primary,
      onPrimary: palette.onPrimary,
      primaryContainer: palette.primaryContainer,
      onPrimaryContainer: palette.onPrimaryContainer,
      secondary: palette.secondary,
      onSecondary: palette.onSecondary,
      secondaryContainer: palette.secondaryContainer,
      onSecondaryContainer: palette.onSecondaryContainer,
      tertiary: palette.tertiary,
      onTertiary: palette.onTertiary,
      tertiaryContainer: palette.tertiaryContainer,
      onTertiaryContainer: palette.onTertiaryContainer,
      error: palette.error,
      onError: palette.onError,
      errorContainer: palette.errorContainer,
      onErrorContainer: palette.onErrorContainer,
      surface: palette.surface,
      surfaceTint: palette.surface.withAlpha(0),
      onSurface: palette.onSurface,
      onSurfaceVariant: palette.onSurfaceVariant,
      outline: palette.outline,
      outlineVariant: palette.outlineVariant,
      shadow: palette.shadow,
      inverseSurface: palette.inverseSurface,
      onInverseSurface: palette.onInverseSurface,
      inversePrimary: palette.inversePrimary,
      surfaceContainerLowest: palette.surfaceLowest,
      surfaceContainerLow: palette.surfaceLow,
      surfaceContainer: palette.surfaceContainer,
      surfaceContainerHigh: palette.surfaceHigh,
      surfaceContainerHighest: palette.surfaceHighest,
    );
  }

  static AppSemanticColors _semanticColors(AppPalette palette) {
    return AppSemanticColors(
      success: palette.success,
      onSuccess: palette.onSuccess,
      successContainer: palette.successContainer,
      onSuccessContainer: palette.onSuccessContainer,
      warning: palette.warning,
      onWarning: palette.onWarning,
      warningContainer: palette.warningContainer,
      onWarningContainer: palette.onWarningContainer,
      error: palette.error,
      onError: palette.onError,
      errorContainer: palette.errorContainer,
      onErrorContainer: palette.onErrorContainer,
      info: palette.info,
      onInfo: palette.onInfo,
      infoContainer: palette.infoContainer,
      onInfoContainer: palette.onInfoContainer,
    );
  }

  static OutlineInputBorder _inputBorder(
    Color color, {
    double width = AppDimensions.strokeWidth,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadii.sm),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
