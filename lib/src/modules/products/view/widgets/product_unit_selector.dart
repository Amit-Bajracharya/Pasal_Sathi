import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/products/model/product_unit.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// A 4-way segmented chip row for picking a [ProductUnit] — the selected
/// chip gets a check mark and a tinted border.
class ProductUnitSelector extends StatelessWidget {
  const ProductUnitSelector({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final ProductUnit selected;
  final ValueChanged<ProductUnit> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final unit in ProductUnit.values) ...[
          if (unit != ProductUnit.values.first) AppSpacing.w8,
          Expanded(
            child: _UnitChip(
              unit: unit,
              selected: unit == selected,
              onTap: () => onChanged(unit),
            ),
          ),
        ],
      ],
    );
  }
}

class _UnitChip extends StatelessWidget {
  const _UnitChip({
    required this.unit,
    required this.selected,
    required this.onTap,
  });

  final ProductUnit unit;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Material(
      color: selected
          ? colorScheme.primary.useOpacity(0.1)
          : colorScheme.surface,
      borderRadius: AppRadius.medium,
      child: InkWell(
        borderRadius: AppRadius.medium,
        onTap: onTap,
        child: Container(
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: AppRadius.medium,
            border: Border.all(
              color: selected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                Icon(Icons.check_rounded, size: 18, color: colorScheme.primary),
                AppSpacing.w4,
              ],
              AppText(
                unit.label,
                style: AppTextStyles.label,
                color: selected ? colorScheme.primary : colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
