import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/sales/model/sale_model.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appCard/app_surface_card.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// One row in the Sales feed: a sequence badge, product + quantity, the
/// sale amount, and a details action.
class SaleTile extends StatelessWidget {
  const SaleTile({
    required this.sale,
    required this.displayNumber,
    this.onDetailsTap,
    super.key,
  });

  final Sale sale;
  final int displayNumber;
  final VoidCallback? onDetailsTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppDimens.p14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: AppText(
                  '#$displayNumber',
                  style: AppTextStyles.label,
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.w8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      sale.productName,
                      style: AppTextStyles.title,
                      color: colorScheme.onSurface,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppText(
                      '${_formatQuantity(sale.quantity)} ${sale.unitLabel} • ${_formatTime(sale.createdAt)}',
                      style: AppTextStyles.label,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              AppText(
                'NPR ${sale.total.toStringAsFixed(0)}',
                style: AppTextStyles.title,
                color: colorScheme.onSurface,
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
              Icon(
                Icons.check_circle_rounded,
                size: 14,
                color: colorScheme.primary,
              ),
              AppSpacing.w4,
              AppText(
                'Logged • ${_formatDate(sale.saleDate)}',
                style: AppTextStyles.label,
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
              const Spacer(),
              InkWell(
                onTap: onDetailsTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      'Details',
                      style: AppTextStyles.label,
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    Icon(
                      Icons.receipt_rounded,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _formatQuantity(double quantity) {
  return quantity == quantity.roundToDouble()
      ? quantity.toStringAsFixed(0)
      : quantity.toString();
}

String _formatTime(DateTime time) {
  final hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.hour >= 12 ? 'PM' : 'AM';
  return '$hour12:$minute $period';
}

String _formatDate(DateTime date) {
  final today = DateTime.now();
  final isToday =
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day;
  if (isToday) return 'Today';

  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${date.day} ${months[date.month - 1]}';
}
