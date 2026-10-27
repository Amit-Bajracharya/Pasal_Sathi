import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appChip/app_pill_chip.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

part 'checkout_tile.freezed.dart';

enum PaymentMethod { fonepay, cash, khata }

/// Data for a single row in the "Recent Checkouts" list.
@freezed
abstract class CheckoutRecord with _$CheckoutRecord {
  const factory CheckoutRecord({
    required String billNumber,
    required PaymentMethod method,
    required String customerLabel,
    required String amountLabel,
    required String timeAgoLabel,
  }) = _CheckoutRecord;
}

class CheckoutTile extends StatelessWidget {
  const CheckoutTile({required this.record, super.key});

  final CheckoutRecord record;

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(record.method);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.p10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: style.avatarBg,
              shape: BoxShape.circle,
            ),
            child: Icon(style.icon, size: 18, color: style.avatarFg),
          ),
          AppSpacing.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      'Bill #${record.billNumber}',
                      style: AppTextStyles.title,
                      color: AppColor.homeOnSurface,
                    ),
                    AppSpacing.w8,
                    AppPillChip(
                      label: style.label,
                      backgroundColor: style.chipBg,
                      foregroundColor: style.chipFg,
                    ),
                  ],
                ),
                AppSpacing.h4,
                AppText(
                  record.customerLabel,
                  style: AppTextStyles.body,
                  color: AppColor.homeOnSurfaceMuted,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                record.amountLabel,
                style: AppTextStyles.body,
                color: record.method == PaymentMethod.khata
                    ? AppColor.homeWarning
                    : AppColor.homeOnSurface,
              ),
              AppSpacing.h4,
              AppText(
                record.timeAgoLabel,
                style: AppTextStyles.body,
                color: AppColor.homeOnSurfaceMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _PaymentStyle _styleFor(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.fonepay:
        return const _PaymentStyle(
          icon: Icons.qr_code_rounded,
          avatarBg: AppColor.homeSuccessContainer,
          avatarFg: AppColor.homeOnSuccessContainer,
          label: 'Fonepay',
          chipBg: AppColor.homeSuccessContainer,
          chipFg: AppColor.homeOnSuccessContainer,
        );
      case PaymentMethod.cash:
        return const _PaymentStyle(
          icon: Icons.payments_rounded,
          avatarBg: AppColor.homeSurfaceContainer,
          avatarFg: AppColor.homeOnSurfaceMuted,
          label: 'Cash',
          chipBg: AppColor.homeSurfaceContainer,
          chipFg: AppColor.homeOnSurfaceMuted,
        );
      case PaymentMethod.khata:
        return const _PaymentStyle(
          icon: Icons.menu_book_rounded,
          avatarBg: AppColor.homeWarningContainer,
          avatarFg: AppColor.homeOnWarningContainer,
          label: 'Khata',
          chipBg: AppColor.homeWarningContainer,
          chipFg: AppColor.homeOnWarningContainer,
        );
    }
  }
}

class _PaymentStyle {
  const _PaymentStyle({
    required this.icon,
    required this.avatarBg,
    required this.avatarFg,
    required this.label,
    required this.chipBg,
    required this.chipFg,
  });

  final IconData icon;
  final Color avatarBg;
  final Color avatarFg;
  final String label;
  final Color chipBg;
  final Color chipFg;
}
