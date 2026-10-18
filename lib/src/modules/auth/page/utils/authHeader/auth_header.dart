import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.isLogin});

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          isLogin ? 'Sign In' : 'Sign Up',
          style: AppTextStyles.display,
          color: context.colorScheme.onSurface,
        ),
        AppSpacing.h8,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.p8),
          child: AppText(
            isLogin
                ? 'Log in to oversee your deliveries and shop inventory. '
                    "If you're new, create an account. "
                    'Need to reset your password?'
                : 'Create an account to start managing your shop, '
                    'orders and deliveries with PasalSathi.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}