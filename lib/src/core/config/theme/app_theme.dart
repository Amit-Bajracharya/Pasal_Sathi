import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';

/// Light and dark [ThemeData] for the app, both seeded from
/// [AppColor.primarySwatch] so the two stay visually consistent.
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: AppColor.primarySwatch,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primarySwatch,
      brightness: Brightness.light,
    ),
    textTheme: AppTextStyles.textTheme,
    scaffoldBackgroundColor: AppColor.baseWhite,
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: AppColor.primarySwatch,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primarySwatch.shade400,
      brightness: Brightness.dark,
    ),
    textTheme: AppTextStyles.textTheme,
    scaffoldBackgroundColor: AppColor.baseBlack,
  );
}
