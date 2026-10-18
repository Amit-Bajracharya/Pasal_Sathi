import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: colorScheme.surface,
        elevation: 1,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Icon(
              Icons.chevron_left_rounded,
              size: 28,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
