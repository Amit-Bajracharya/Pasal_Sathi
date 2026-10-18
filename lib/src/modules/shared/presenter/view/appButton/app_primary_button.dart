import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.label,
    required this.onPressed,
    this.height = 54,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: primary.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.pill),
        ),
        child: AppText(
          label,
          fontWeight: FontWeight.w600,
          fontSize: AppDimens.p15,
          color: Colors.white,
        ),
      ),
    );
  }
}
