import 'package:flutter/material.dart';

class AppPalette {
  const AppPalette({
    required this.brightness,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.background,
    required this.surface,
    required this.surfaceLowest,
    required this.surfaceLow,
    required this.surfaceContainer,
    required this.surfaceHigh,
    required this.surfaceHighest,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
  });

  final Brightness brightness;
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color background;
  final Color surface;
  final Color surfaceLowest;
  final Color surfaceLow;
  final Color surfaceContainer;
  final Color surfaceHigh;
  final Color surfaceHighest;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;

  static const light = AppPalette(
    brightness: Brightness.light,
    primary: Color(0xFF5B5CE2),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE8E9FF),
    onPrimaryContainer: Color(0xFF25276B),
    secondary: Color(0xFF138F86),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD7F4EF),
    onSecondaryContainer: Color(0xFF075E58),
    tertiary: Color(0xFF2B67B1),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE2EEFF),
    onTertiaryContainer: Color(0xFF153D6A),
    background: Color(0xFFF7F8FC),
    surface: Color(0xFFFFFFFF),
    surfaceLowest: Color(0xFFFFFFFF),
    surfaceLow: Color(0xFFFCFCFE),
    surfaceContainer: Color(0xFFF0F2F7),
    surfaceHigh: Color(0xFFE8EBF2),
    surfaceHighest: Color(0xFFDEE2EC),
    onSurface: Color(0xFF171A2B),
    onSurfaceVariant: Color(0xFF62677D),
    outline: Color(0xFFC7CBD8),
    outlineVariant: Color(0xFFE1E4EC),
    shadow: Color(0xFF171A2B),
    inverseSurface: Color(0xFF2B2E3E),
    onInverseSurface: Color(0xFFF4F5FB),
    inversePrimary: Color(0xFFBFC0FF),
    success: Color(0xFF168563),
    onSuccess: Color(0xFFFFFFFF),
    successContainer: Color(0xFFDDF6EA),
    onSuccessContainer: Color(0xFF0B5A41),
    warning: Color(0xFFA85E08),
    onWarning: Color(0xFFFFFFFF),
    warningContainer: Color(0xFFFFF0D1),
    onWarningContainer: Color(0xFF713F00),
    error: Color(0xFFC33D50),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFE3E7),
    onErrorContainer: Color(0xFF7E1727),
    info: Color(0xFF2B67B1),
    onInfo: Color(0xFFFFFFFF),
    infoContainer: Color(0xFFE2EEFF),
    onInfoContainer: Color(0xFF153D6A),
  );

  static const dark = AppPalette(
    brightness: Brightness.dark,
    primary: Color(0xFFB6B7FF),
    onPrimary: Color(0xFF282A72),
    primaryContainer: Color(0xFF45479B),
    onPrimaryContainer: Color(0xFFE5E6FF),
    secondary: Color(0xFF70D9CB),
    onSecondary: Color(0xFF003731),
    secondaryContainer: Color(0xFF0A5A52),
    onSecondaryContainer: Color(0xFFA8F5EA),
    tertiary: Color(0xFFA7C8FF),
    onTertiary: Color(0xFF00315C),
    tertiaryContainer: Color(0xFF214D7A),
    onTertiaryContainer: Color(0xFFD3E5FF),
    background: Color(0xFF10121A),
    surface: Color(0xFF161923),
    surfaceLowest: Color(0xFF0A0C12),
    surfaceLow: Color(0xFF161923),
    surfaceContainer: Color(0xFF1C202C),
    surfaceHigh: Color(0xFF272C3A),
    surfaceHighest: Color(0xFF343A4B),
    onSurface: Color(0xFFF3F4FA),
    onSurfaceVariant: Color(0xFFB6BACB),
    outline: Color(0xFF7A8093),
    outlineVariant: Color(0xFF3D4353),
    shadow: Color(0xFF000000),
    inverseSurface: Color(0xFFF3F4FA),
    onInverseSurface: Color(0xFF1B1E2A),
    inversePrimary: Color(0xFF5B5CE2),
    success: Color(0xFF73DCB0),
    onSuccess: Color(0xFF003824),
    successContainer: Color(0xFF0B5B40),
    onSuccessContainer: Color(0xFFA2F8CE),
    warning: Color(0xFFF2B95F),
    onWarning: Color(0xFF452700),
    warningContainer: Color(0xFF6B4000),
    onWarningContainer: Color(0xFFFFDCAA),
    error: Color(0xFFFFB2BC),
    onError: Color(0xFF680019),
    errorContainer: Color(0xFF8D1830),
    onErrorContainer: Color(0xFFFFD9DE),
    info: Color(0xFFA7C8FF),
    onInfo: Color(0xFF00315C),
    infoContainer: Color(0xFF214D7A),
    onInfoContainer: Color(0xFFD3E5FF),
  );
}
