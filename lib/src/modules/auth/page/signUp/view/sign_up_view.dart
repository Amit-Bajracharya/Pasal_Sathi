import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appTextField/app_text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({
    required this.shopNameController,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  final TextEditingController shopNameController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('signup'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          labelText: 'Shop Name',
          textEditingController: widget.shopNameController,
          hintText: 'Enter your shop name',
          keyboardType: TextInputType.text,
          isMandatory: true,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Enter your shop name' : null,
        ),
        AppTextField(
          labelText: 'Full Name',
          textEditingController: widget.nameController,
          hintText: 'Enter your name',
          keyboardType: TextInputType.name,
          isMandatory: true,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
        ),
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
        AppTextField(
          labelText: 'Confirm Password',
          textEditingController: _confirmController,
          hintText: 'Re-enter password',
          isPassword: true,
          isMandatory: true,
          validator: (v) => v != widget.passwordController.text
              ? 'Passwords do not match'
              : null,
        ),
      ],
    );
  }
}
