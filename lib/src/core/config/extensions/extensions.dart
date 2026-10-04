import 'dart:ui' show Color;

import 'package:flutter/material.dart'
    show BuildContext, ColorScheme, Theme, ThemeData;

extension NullableStringExtension on String? {
  bool get exists => this != null && this!.isNotEmpty;
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String capitalizeEachWord() {
    if (isEmpty) return this;
    return split(
      RegExp(r'\s+'),
    ).map((word) => word.isEmpty ? word : word.capitalize()).join(' ');
  }

  String toDisplayText() {
    final cleaned = replaceAll('_', '').trim().replaceAll(RegExp(r'\s+'), ' ');
    if (cleaned.isEmpty) return cleaned;
    return cleaned
        .split(' ')
        .map((word) {
          if (word.toLowerCase() == 'and') return 'and';
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  String get firstContactNumber {
    if (isEmpty) return this;
    final parts = split(RegExp('[;,/|]+'));
    return parts.first.trim();
  }
}

extension StringListExtension on List<String> {
  String joinNonEmpty({String separator = ', '}) {
    return where(
      (p) => p.trim().isNotEmpty,
    ).map((p) => p.trim()).join(separator);
  }
}

extension ColorExtension on Color {
  Color useOpacity(double opacity) {
    return withAlpha((opacity * 255).round());
  }
}

extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}


