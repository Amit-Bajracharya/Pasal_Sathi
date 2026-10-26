import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/products/model/product.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appCard/app_surface_card.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appChip/app_pill_chip.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// One row in the Products list: category/tag chips, name, pricing with
/// margin, stock level, and a status-appropriate action (Edit + Stock for
/// healthy stock, Restock for low/out-of-stock).
class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    this.onEdit,
    this.onAddStock,
    this.onMore,
    super.key,
  });

  final Product product;
  final VoidCallback? onEdit;
  final VoidCallback? onAddStock;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final accent = _accentColor(colorScheme);

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppDimens.p14),
      border: accent == null
          ? null
          : Border(left: BorderSide(color: accent, width: 3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: AppDimens.p8,
                      runSpacing: AppDimens.p4,
                      children: [
                        AppPillChip(
                          label: '${product.category} • ${product.unitLabel}',
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          foregroundColor: colorScheme.onSurfaceVariant,
                        ),
                        if (product.status == ProductStockStatus.normal)
                          AppText(
                            product.tagLabel,
                            style: AppTextStyles.label,
                            color: colorScheme.outline,
                          )
                        else
                          AppPillChip(
                            label: product.status == ProductStockStatus.lowStock
                                ? 'Low Stock'
                                : 'Out of Stock',
                            icon: product.status == ProductStockStatus.lowStock
                                ? Icons.warning_rounded
                                : Icons.error_rounded,
                            backgroundColor:
                                product.status == ProductStockStatus.lowStock
                                ? colorScheme.tertiaryContainer
                                : colorScheme.errorContainer,
                            foregroundColor:
                                product.status == ProductStockStatus.lowStock
                                ? colorScheme.onTertiaryContainer
                                : colorScheme.onErrorContainer,
                          ),
                      ],
                    ),
                    AppSpacing.h4,
                    AppText(
                      product.name,
                      style: AppTextStyles.title,
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onMore,
                borderRadius: AppRadius.pill,
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.p4),
                  child: Icon(
                    Icons.more_vert_rounded,
                    size: 20,
                    color: colorScheme.outline,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.p10),
            child: Divider(
              height: 1,
              color: colorScheme.surfaceContainerHighest,
            ),
          ),
          Row(
            children: [
              AppText(
                'NPR ${product.sellingPrice.toStringAsFixed(0)}',
                style: AppTextStyles.title,
                color: colorScheme.onSurface,
              ),
              AppSpacing.w6,
              AppText(
                'Cost: NPR ${product.costPrice.toStringAsFixed(0)}',
                style: AppTextStyles.label,
                color: colorScheme.outline,
              ),
              const Spacer(),
              AppPillChip(
                label:
                    '+NPR ${product.margin.toStringAsFixed(0)} (${product.marginPercent.toStringAsFixed(0)}%)',
                backgroundColor: colorScheme.secondaryContainer,
                foregroundColor: colorScheme.onSecondaryContainer,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.p10),
            child: Divider(
              height: 1,
              color: colorScheme.surfaceContainerHighest.useOpacity(0.6),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: accent ?? colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppSpacing.w8,
                    Expanded(
                      child: AppText(
                        product.stockLabel,
                        style: AppTextStyles.bodySmall,
                        color: accent ?? colorScheme.onSurface,
                        fontWeight: accent == null
                            ? FontWeight.w500
                            : FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.w8,
              ..._actions(colorScheme),
            ],
          ),
        ],
      ),
    );
  }

  Color? _accentColor(ColorScheme colorScheme) {
    switch (product.status) {
      case ProductStockStatus.normal:
        return null;
      case ProductStockStatus.lowStock:
        return colorScheme.tertiary;
      case ProductStockStatus.outOfStock:
        return colorScheme.error;
    }
  }

  List<Widget> _actions(ColorScheme colorScheme) {
    switch (product.status) {
      case ProductStockStatus.normal:
        return [
          _ActionButton(
            label: 'Edit',
            icon: Icons.edit_outlined,
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
            borderColor: colorScheme.outlineVariant,
            onTap: onEdit,
          ),
          AppSpacing.w8,
          _ActionButton(
            label: 'Stock',
            icon: Icons.add_rounded,
            backgroundColor: colorScheme.primary.useOpacity(0.1),
            foregroundColor: colorScheme.primary,
            onTap: onAddStock,
          ),
        ];
      case ProductStockStatus.lowStock:
        return [
          _ActionButton(
            label: 'Restock',
            icon: Icons.add_shopping_cart_rounded,
            backgroundColor: colorScheme.tertiary,
            foregroundColor: colorScheme.onTertiary,
            onTap: onAddStock,
          ),
        ];
      case ProductStockStatus.outOfStock:
        return [
          _ActionButton(
            label: 'Restock Now',
            icon: Icons.add_circle_rounded,
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
            onTap: onAddStock,
          ),
        ];
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: AppRadius.normal,
      child: InkWell(
        borderRadius: AppRadius.normal,
        onTap: onTap,
        child: Container(
          decoration: borderColor == null
              ? null
              : BoxDecoration(
                  borderRadius: AppRadius.normal,
                  border: Border.all(color: borderColor!),
                ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.p12,
            vertical: AppDimens.p8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: foregroundColor),
              AppSpacing.w4,
              AppText(
                label,
                style: AppTextStyles.label,
                color: foregroundColor,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
