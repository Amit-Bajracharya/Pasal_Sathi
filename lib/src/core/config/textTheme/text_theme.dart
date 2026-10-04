import 'package:flutter/material.dart';
import 'package:pasal_sathi/gen/fonts.gen.dart';


class AppTextStyles {
  static const String _fontFamily = FontFamily.jakartaSans;

  static const TextStyle display = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    height: 1.20,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 21,
    height: 1.25,
    letterSpacing: -0.1,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle title = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    height: 1.30,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    height: 1.45,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    height: 1.45,
    letterSpacing: 0.2,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle label = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    height: 1.20,
    letterSpacing: 0.4,
    fontWeight: FontWeight.w500,
  );

  static TextTheme get textTheme => const TextTheme(
    displayLarge: display,
    displayMedium: display,
    displaySmall: headline,
    headlineLarge: headline,
    headlineMedium: title,
    headlineSmall: title,
    titleLarge: title,
    titleMedium: body,
    titleSmall: bodySmall,
    bodyLarge: body,
    bodyMedium: bodySmall,
    bodySmall: label,
    labelLarge: label,
    labelMedium: label,
    labelSmall: label,
  );

  static TextStyle? get headlineMedium => null;
}
