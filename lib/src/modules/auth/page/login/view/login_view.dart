import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appTextField/app_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    required this.emailController,
    required this.passwordController,
    this.onForgotPassword,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback? onForgotPassword;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _remember = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('login'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          labelText: 'Email',
          textEditingController: widget.emailController,
          hintText: 'you@example.com',
          keyboardType: TextInputType.emailAddress,
          isMandatory: true,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return 'Enter your email';
            if (!v.contains('@') || !v.contains('.')) {
              return 'Enter a valid email';
            }
            return null;
          },
        ),
        AppTextField(
          labelText: 'Password',
          textEditingController: widget.passwordController,
          hintText: 'Enter Password',
          isPassword: true,
          isMandatory: true,
          validator: (v) =>
              (v == null || v.length < 6) ? 'At least 6 characters' : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => setState(() => _remember = !_remember),
              borderRadius: AppRadius.small,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: _remember,
                      activeColor: context.colorScheme.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (v) => setState(() => _remember = v ?? false),
                    ),
                  ),
                  AppSpacing.w8,
                  AppText(
                    'Remember me',
                    style: AppTextStyles.label,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: widget.onForgotPassword,
              child: AppText(
                'Forgot password?',
                style: AppTextStyles.label,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.error,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
