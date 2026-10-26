import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appChip/app_pill_chip.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// A live profit/loss readout for a selling price vs. cost price pair —
/// neutral until both are entered, green when profitable, red if selling
/// below cost.
class ProfitBanner extends StatelessWidget {
  const ProfitBanner({
    required this.sellingPrice,
    required this.costPrice,
    super.key,
  });

  final double? sellingPrice;
  final double? costPrice;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final selling = sellingPrice ?? 0;
    final cost = costPrice ?? 0;

    if (selling <= 0 && cost <= 0) {
      return _Banner(
        backgroundColor: colorScheme.surfaceContainerHighest,
        foregroundColor: colorScheme.outline,
        borderColor: colorScheme.outlineVariant,
        icon: Icons.info_outline_rounded,
        text: 'Enter selling and cost price',
      );
    }

    final diff = selling - cost;
    if (diff < 0) {
      return _Banner(
        backgroundColor: colorScheme.errorContainer,
        foregroundColor: colorScheme.error,
        borderColor: colorScheme.error.useOpacity(0.2),
        icon: Icons.warning_rounded,
        text: 'Selling below cost: Loss NPR ${diff.abs().toStringAsFixed(0)}',
        badgeLabel: 'Loss Warning',
        badgeBackgroundColor: colorScheme.error,
        badgeForegroundColor: colorScheme.onError,
      );
    }

    final marginPercent = selling > 0 ? (diff / selling * 100).round() : 0;
    return _Banner(
      backgroundColor: colorScheme.primary.useOpacity(0.1),
      foregroundColor: colorScheme.primary,
      borderColor: colorScheme.primary.useOpacity(0.2),
      icon: Icons.trending_up_rounded,
      text: 'Profit per unit: NPR ${diff.toStringAsFixed(0)} ($marginPercent%)',
      badgeLabel: 'Profitable',
      badgeBackgroundColor: colorScheme.primary,
      badgeForegroundColor: colorScheme.onPrimary,
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.icon,
    required this.text,
    this.badgeLabel,
    this.badgeBackgroundColor,
    this.badgeForegroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final IconData icon;
  final String text;
  final String? badgeLabel;
  final Color? badgeBackgroundColor;
  final Color? badgeForegroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.p12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.medium,
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: foregroundColor),
          AppSpacing.w8,
          Expanded(
            child: AppText(
              text,
              style: AppTextStyles.label,
              color: foregroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (badgeLabel != null) ...[
            AppSpacing.w8,
            AppPillChip(
              label: badgeLabel!,
              backgroundColor: badgeBackgroundColor!,
              foregroundColor: badgeForegroundColor!,
            ),
          ],
        ],
      ),
    );
  }
}
