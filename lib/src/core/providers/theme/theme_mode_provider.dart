import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_provider.g.dart';

/// Controls the app's [ThemeMode].
///
/// Defaults to [ThemeMode.system] so the app follows the device's
/// light/dark setting out of the box. Exposed as a controller so a
/// settings screen can later override it to light/dark/system explicitly.
@riverpod
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() => ThemeMode.system;

  void setLight() => state = ThemeMode.light;

  void setDark() => state = ThemeMode.dark;

  void setSystem() => state = ThemeMode.system;

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}
