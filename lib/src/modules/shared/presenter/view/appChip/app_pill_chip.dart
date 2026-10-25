import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// A small pill-shaped badge for statuses, counts, and tags — e.g. "Open",
/// a trend/quantity count, or a payment-method label.
class AppPillChip extends StatelessWidget {
  const AppPillChip({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.icon,
    this.dot = false,
    super.key,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? icon;
  final bool dot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.p10,
        vertical: AppDimens.p4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: foregroundColor,
                shape: BoxShape.circle,
              ),
            ),
            AppSpacing.w4,
          ],
          if (icon != null) ...[
            Icon(icon, size: 14, color: foregroundColor),
            AppSpacing.w4,
          ],
          AppText(
            label,
            color: foregroundColor,
            fontWeight: FontWeight.w600,
            fontSize: AppDimens.p12,
          ),
        ],
      ),
    );
  }
}
