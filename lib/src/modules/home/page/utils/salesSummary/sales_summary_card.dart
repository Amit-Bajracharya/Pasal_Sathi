import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';

import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// The large gradient "Today's Summary" hero card: headline amount, a
/// vs-yesterday trend badge, and a settled-bills / target footer row.
class SalesSummaryCard extends StatelessWidget {
  const SalesSummaryCard({
    required this.totalLabel,
    required this.amount,
    required this.currencyLabel,
    required this.trendLabel,
    required this.billsSettledLabel,
    required this.targetLabel,
    super.key,
  });

  final String totalLabel;
  final String amount;
  final String currencyLabel;
  final String trendLabel;
  final String billsSettledLabel;
  final String targetLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.p20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.homePrimaryDark, AppColor.homePrimary],
        ),
        borderRadius: BorderRadius.circular(AppDimens.p20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                totalLabel,
                style: AppTextStyles.title,
                color: Colors.white.withValues(alpha: 0.85),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.p10,
                  vertical: AppDimens.p4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: AppRadius.pill,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.trending_up_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                    AppSpacing.w4,
                    AppText(
                      trendLabel,
                      style: AppTextStyles.title,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.h12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              AppText(amount, style: AppTextStyles.title, color: Colors.white),
              AppSpacing.w6,
              AppText(
                currencyLabel,
                style: AppTextStyles.body,
                color: Colors.white.withValues(alpha: 0.75),
              ),
            ],
          ),
          AppSpacing.h16,
          Container(height: 1, color: Colors.white.withValues(alpha: 0.2)),
          AppSpacing.h12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.receipt_long_rounded,
                    size: 16,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                  AppSpacing.w6,
                  AppText(
                    billsSettledLabel,
                    style: AppTextStyles.bodySmall,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ],
              ),
              AppText(
                targetLabel,
                style: AppTextStyles.bodySmall,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
