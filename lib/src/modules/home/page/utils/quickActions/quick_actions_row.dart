import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// Primary action row: New Sale (emphasized), Scan, Khata, and a trailing
/// "more" square button.
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key, 
    this.onNewSale,
    this.onNewProduct,
  
  });

  final VoidCallback? onNewSale;
  final VoidCallback? onNewProduct;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _ActionPill(
            label: 'New Sale',
            icon: Icons.add_circle_rounded,
            backgroundColor: AppColor.homePrimary,
            foregroundColor: Colors.white,
            onTap: onNewSale,
          ),
        ),
        AppSpacing.w8,
        Expanded(
          flex: 2,
          child: _ActionPill(
            label: 'Add New Product',
            icon: Icons.add_circle_rounded,
            backgroundColor: AppColor.homePrimary,
            foregroundColor: Colors.white,
            onTap: onNewProduct,
          ),
        ),
       

      ],
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: AppRadius.pill,
      child: InkWell(
        borderRadius: AppRadius.pill,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.p12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: foregroundColor),
              AppSpacing.w6,
              AppText(label, style: AppTextStyles.body, color: foregroundColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  const _SquareIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.homeSurfaceContainer,
      borderRadius: BorderRadius.circular(AppDimens.p14),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimens.p14),
        onTap: onTap,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, color: AppColor.homeOnSurface),
        ),
      ),
    );
  }
}
