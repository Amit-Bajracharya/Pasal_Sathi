import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// A tappable, selectable pill — used for the category/stock filter row
/// above the products list. Unlike [AppPillChip], this reacts to taps and
/// carries its own selected/unselected styling.
class ProductFilterChip extends StatelessWidget {
  const ProductFilterChip({
    required this.label,
    required this.selected,
    this.dotColor,
    this.onTap,
    super.key,
  });

  final String label;
  final bool selected;

  /// A small leading dot (e.g. the amber "Low Stock" indicator), shown
  /// regardless of selection state.
  final Color? dotColor;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Material(
      color: selected ? colorScheme.primaryContainer : colorScheme.surface,
      borderRadius: AppRadius.pill,
      child: InkWell(
        borderRadius: AppRadius.pill,
        onTap: onTap,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.p14),
          decoration: BoxDecoration(
            borderRadius: AppRadius.pill,
            border: selected
                ? null
                : Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dotColor != null) ...[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                AppSpacing.w6,
              ],
              AppText(
                label,
                style: AppTextStyles.label,
                color: selected
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
