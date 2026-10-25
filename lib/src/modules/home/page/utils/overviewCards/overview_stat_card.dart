import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';

import 'package:pasal_sathi/src/modules/shared/presenter/view/appCard/app_surface_card.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// A small stat tile: label + icon badge on top, a big value, and an
/// accent-colored caption underneath. Used for Khata Due / Low Stock Alert.
class OverviewStatCard extends StatelessWidget {
  const OverviewStatCard({
    required this.label,
    required this.value,
    required this.caption,
    required this.icon,
    required this.accentColor,
    required this.accentContainerColor,
    this.valueColor,
    super.key,
  });

  final String label;
  final String value;
  final String caption;
  final IconData icon;
  final Color accentColor;
  final Color accentContainerColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText(
                  label,
                  style: AppTextStyles.title,
                  color: AppColor.homeOnSurfaceMuted,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accentContainerColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16, color: accentColor),
              ),
            ],
          ),
          AppSpacing.h8,
          AppText(
            value,
            style: AppTextStyles.title,
            color: valueColor ?? AppColor.homeOnSurface,
          ),
          AppSpacing.h4,
          AppText(caption, style: AppTextStyles.body, color: accentColor),
        ],
      ),
    );
  }
}
