import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appTextField/app_text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({
    required this.phoneController,
    required this.passwordController,
    super.key,
  });

  final TextEditingController phoneController;
  final TextEditingController passwordController;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _nameController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
          labelText: 'Full Name',
          textEditingController: _nameController,
          hintText: 'Enter your name',
          keyboardType: TextInputType.name,
          isMandatory: true,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Enter your name' : null,
        ),
        AppTextField(
          labelText: 'Phone Number',
          textEditingController: widget.phoneController,
          hintText: '98XXXXXXXX',
          keyboardType: TextInputType.phone,
          isMandatory: true,
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Enter phone number' : null,
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
