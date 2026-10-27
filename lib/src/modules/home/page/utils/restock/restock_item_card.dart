import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';

import 'package:pasal_sathi/src/modules/shared/presenter/view/appChip/app_pill_chip.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

part 'restock_item_card.freezed.dart';

/// Data for a single low-stock product row.
@freezed
abstract class RestockItem with _$RestockItem {
  const factory RestockItem({
    required String name,
    required String quantityLabel,
    required String caption,
    @Default(false) bool isUrgent,
  }) = _RestockItem;
}

/// A left-accented card for one item needing restock, with a quantity
/// chip and a Reorder action (filled for the most urgent item, tonal
/// otherwise).
class RestockItemCard extends StatelessWidget {
  const RestockItemCard({required this.item, this.onReorder, super.key});

  final RestockItem item;
  final VoidCallback? onReorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimens.p16),
        border: const Border(
          left: BorderSide(color: AppColor.homeDanger, width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.homeOnSurface.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.p16,
        vertical: AppDimens.p14,
      ),
      child: Row(
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
                    AppText(
                      item.name,
                      style: AppTextStyles.title,
                      color: AppColor.homeOnSurface,
                    ),
                    AppPillChip(
                      label: item.quantityLabel,
                      backgroundColor: AppColor.homeWarningContainer,
                      foregroundColor: AppColor.homeOnWarningContainer,
                    ),
                  ],
                ),
                AppSpacing.h4,
                AppText(
                  item.caption,
                  style: AppTextStyles.title,
                  color: AppColor.homeOnSurfaceMuted,
                ),
              ],
            ),
          ),
          AppSpacing.w12,
          _ReorderButton(filled: item.isUrgent, onTap: onReorder),
        ],
      ),
    );
  }
}

class _ReorderButton extends StatelessWidget {
  const _ReorderButton({required this.filled, this.onTap});

  final bool filled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = filled ? AppColor.homePrimary : AppColor.homeSurfaceContainer;
    final fg = filled ? Colors.white : AppColor.homeOnSurface;
    return Material(
      color: bg,
      borderRadius: AppRadius.pill,
      child: InkWell(
        borderRadius: AppRadius.pill,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.p16,
            vertical: AppDimens.p10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (filled) ...[
                const Icon(
                  Icons.local_shipping_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                AppSpacing.w6,
              ],
              AppText('Reorder', style: AppTextStyles.title, color: fg),
            ],
          ),
        ),
      ),
    );
  }
}
