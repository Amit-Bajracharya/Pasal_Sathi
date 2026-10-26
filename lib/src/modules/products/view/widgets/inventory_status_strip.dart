import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appCard/app_surface_card.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appChip/app_pill_chip.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// A bento-style "INVENTORY STATUS" strip: total stock value, how many
/// items are healthy, and how many need restocking.
class InventoryStatusStrip extends StatelessWidget {
  const InventoryStatusStrip({
    required this.totalValueLabel,
    required this.totalValueTrendLabel,
    required this.inStockLabel,
    required this.inStockCaption,
    required this.restockLabel,
    super.key,
  });

  final String totalValueLabel;
  final String totalValueTrendLabel;
  final String inStockLabel;
  final String inStockCaption;
  final String restockLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppDimens.p14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics_outlined,
                size: 18,
                color: colorScheme.primary,
              ),
              AppSpacing.w6,
              AppText(
                'INVENTORY STATUS',
                style: AppTextStyles.label,
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              AppText(
                'Updated just now',
                style: AppTextStyles.label,
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
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
              Expanded(
                child: _Stat(
                  label: 'Total Value',
                  value: totalValueLabel,
                  caption: totalValueTrendLabel,
                  captionColor: colorScheme.primary,
                ),
              ),
              _divider(colorScheme),
              Expanded(
                child: _Stat(
                  label: 'In Stock',
                  value: inStockLabel,
                  valueColor: colorScheme.primary,
                  caption: inStockCaption,
                  captionColor: colorScheme.outline,
                ),
              ),
              _divider(colorScheme),
              Expanded(
                child: _Stat(
                  label: 'Needs Restock',
                  value: restockLabel,
                  valueColor: colorScheme.tertiary,
                  badge: 'Attention',
                  badgeBackgroundColor: colorScheme.tertiaryContainer,
                  badgeForegroundColor: colorScheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider(ColorScheme colorScheme) {
    return Container(
      width: 1,
      height: 44,
      color: colorScheme.surfaceContainerHighest,
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.value,
    this.valueColor,
    this.caption,
    this.captionColor,
    this.badge,
    this.badgeBackgroundColor,
    this.badgeForegroundColor,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final String? caption;
  final Color? captionColor;
  final String? badge;
  final Color? badgeBackgroundColor;
  final Color? badgeForegroundColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          label,
          style: AppTextStyles.label,
          color: colorScheme.outline,
          textAlign: TextAlign.center,
        ),
        AppSpacing.h4,
        AppText(
          value,
          style: AppTextStyles.title,
          color: valueColor ?? colorScheme.onSurface,
          textAlign: TextAlign.center,
        ),
        AppSpacing.h4,
        if (badge != null)
          AppPillChip(
            label: badge!,
            backgroundColor: badgeBackgroundColor!,
            foregroundColor: badgeForegroundColor!,
          )
        else if (caption != null)
          AppText(
            caption!,
            style: AppTextStyles.label,
            color: captionColor ?? colorScheme.outline,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
