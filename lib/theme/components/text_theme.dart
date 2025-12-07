import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

/// Text theme usage guide:
/// App title / page title → titleLarge
/// Card title → titleMedium
/// Section header → headlineSmall
/// Paragraph text → bodyMedium
/// Secondary helper text / metadata → bodySmall
/// Button text / chips → labelLarge or labelSmall
/// Tiny footnotes → bodySmall / labelSmall
///
/// displayLarge: 48–60, weight 400–600
/// headlineLarge: 28–34, weight 500
/// titleLarge: 18–20, weight 600
/// titleMedium: 16, weight 600
/// bodyLarge: 16, weight 400
/// bodyMedium: 14, weight 400 ← default mobile body
/// bodySmall: 12, weight 400
///labelLarge: 14, weight 600 (button text)
///labelSmall: 12, weight 600

class AppTextTheme {
  static TextTheme baseTextTheme(ColorScheme cs) {
    final base = GoogleFonts.senTextTheme(Typography.englishLike2018);

    return base.copyWith(
      // Big / hero
      displayLarge: base.displayLarge?.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.1,
        color: cs.onSurface,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 1.12,
        color: cs.onSurface,
      ),
      displaySmall: base.displaySmall?.copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 1.15,
        color: cs.onSurface,
      ),

      // Section headings
      headlineLarge: base.headlineLarge?.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: cs.onSurface,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.22,
        color: cs.onSurface,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: cs.onSurface,
      ),

      // Titles (appBar, card titles)
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: cs.onSurface,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: cs.onSurface,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: cs.onSurface,
      ),

      // Body text
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: cs.onSurface.withAlpha(183),
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: cs.onSurface.withAlpha(183),
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: cs.onSurface.withAlpha(183),
      ),

      // Labels (buttons, chips)
      labelLarge: base.labelLarge?.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 1.0,
        color: cs.onPrimary,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.0,
        color: cs.onPrimary.withAlpha(183),
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.0,
        color: cs.onSurface.withAlpha(183),
      ),
    );
  }
}
