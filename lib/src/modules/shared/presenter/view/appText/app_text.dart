import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';



/// A small wrapper over [Text] that:
/// - Merges a provided [style] with optional [color]/[fontWeight] overrides
/// - (Optionally) constrains width via [width]
/// - Supports [maxLines] and [overflow] properly
/// - Uses a sensible default style (AppTextStyles.body) if none provided
class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.width,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.decoration,
    this.decorationColor,
  });

  final String text;
  final TextStyle? style;
  final Color? color;
  final FontWeight? fontWeight;

  final double? fontSize;

  final TextAlign? textAlign;
  final double? width;

  /// If you want ellipsis, set this (and usually [overflow] to [TextOverflow.
  /// ellipsis]).
  final int? maxLines;

  /// Defaults to `null` (inherits Text's default). If you want truncation, set
  /// to `TextOverflow.ellipsis`.
  final TextOverflow? overflow;

  /// Optionally control wrapping behavior. If null, Text's default applies.
  final bool? softWrap;

  /// Optionally control text decoration (e.g. underline, strikethrough).
  /// If null, inherits from [style] (or has none).
  final TextDecoration? decoration;

  /// Optionally control the color of the [decoration] (e.g. underline color).
  /// If null, inherits from [style], falling back to the text color.
  final Color? decorationColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    final base = style ?? AppTextStyles.body;

    // Merge while allowing explicit overrides
    final effectiveStyle = base.copyWith(
      color: color ?? theme.colorScheme.onSurface,
      fontWeight: fontWeight ?? base.fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? base.fontSize,
      decoration: decoration ?? base.decoration,
      decorationColor: decorationColor ?? base.decorationColor,
    );

    final textWidget = Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: effectiveStyle,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );

    if (width != null) {
      return SizedBox(width: width, child: textWidget);
    }
    return textWidget;
  }
}
