import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key, required this.isLogin, required this.onTap});

  final bool isLogin;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          isLogin ? "Haven't any account? " : 'Already have an account? ',
          style: AppTextStyles.label,
          color: context.colorScheme.onSurfaceVariant,
        ),
        GestureDetector(
          onTap: onTap,
          child: AppText(
            isLogin ? 'Sign Up' : 'Sign In',
            style: AppTextStyles.label,
            fontWeight: FontWeight.w700,
            color: context.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
