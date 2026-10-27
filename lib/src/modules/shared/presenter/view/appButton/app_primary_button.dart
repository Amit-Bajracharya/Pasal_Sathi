import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.label,
    required this.onPressed,
    this.height = 48,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final double height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: primary.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.pill),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : AppText(
                label,
                fontWeight: FontWeight.w600,
                fontSize: AppDimens.p15,
                color: Colors.white,
              ),
      ),
    );
  }
}
