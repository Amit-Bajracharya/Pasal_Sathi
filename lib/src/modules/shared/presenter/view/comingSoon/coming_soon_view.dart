import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// Centered icon + title + "coming soon" placeholder for a tab whose
/// screen hasn't been built yet.
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({required this.title, required this.icon, super.key});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: AppColor.homeOnSurfaceMuted),
          AppSpacing.h12,
          AppText(
            title,
            style: AppTextStyles.title,
            color: AppColor.homeOnSurface,
          ),
          AppSpacing.h4,
          AppText(
            'Coming soon',
            style: AppTextStyles.bodySmall,
            color: AppColor.homeOnSurfaceMuted,
          ),
        ],
      ),
    );
  }
}
