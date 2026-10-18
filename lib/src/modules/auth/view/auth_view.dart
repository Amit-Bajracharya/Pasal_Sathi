import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/auth/data/repository/auth_repository.dart';
import 'package:pasal_sathi/src/modules/auth/page/login/view/login_view.dart';
import 'package:pasal_sathi/src/modules/auth/page/signUp/view/sign_up_view.dart';
import 'package:pasal_sathi/src/modules/auth/page/utils/authFooter/auth_footer.dart';
import 'package:pasal_sathi/src/modules/auth/page/utils/authHeader/auth_header.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appButton/app_primary_button.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appDivider/app_or_divider.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appScaffold/app_scaffold_widget.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appToggle/app_segmented_toggle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLogin = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _setMode(bool isLogin) {
    if (_isLogin == isLogin) return;
    setState(() => _isLogin = isLogin);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (!_isLogin) {
      // YOUR TURN: once AuthRepository.signUpWithPhone exists, call it the
      // same way _submit calls signInWithPhone below — read the repository,
      // await the call inside the same try/catch/finally shape, and show a
      // snackbar on both success (e.g. "check your phone for the OTP") and
      // AuthException failure.
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await ref.read(authRepositoryProvider).signInWithPhone(
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      // TODO: navigate to your home/dashboard route on success.
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: Column(
        children: [
          Expanded(
            child: Container(
             
            
              color: context.colorScheme.surface,
              
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.p24,
                      AppDimens.p12,
                      AppDimens.p24,
                      AppDimens.p24,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AuthHeader(isLogin: _isLogin),
                          AppSpacing.h24,
                          AppSegmentedToggle(
                            options: const ['Login', 'Sign Up'],
                            selectedIndex: _isLogin ? 0 : 1,
                            onChanged: (index) => _setMode(index == 0),
                          ),
                          AppSpacing.h24,
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: _isLogin
                                ? LoginView(
                                    phoneController: _phoneController,
                                    passwordController: _passwordController,
                                    onForgotPassword: () {
                                      // TODO: navigate to ForgetPasswordRoute
                                    },
                                  )
                                : SignUpView(
                                    phoneController: _phoneController,
                                    passwordController: _passwordController,
                                  ),
                          ),
                          AppSpacing.h20,
                          AppPrimaryButton(
                            label: _isLogin ? 'Log In' : 'Create Account',
                            onPressed: _submit,
                            isLoading: _isSubmitting,
                          ),
                          AppSpacing.h20,
                          const AppOrDivider(),
    
                          AppSpacing.h20,
                          AuthFooter(isLogin: _isLogin, onTap: () => _setMode(!_isLogin)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



