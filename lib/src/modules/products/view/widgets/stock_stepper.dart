import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';

/// A minus/number/plus row for entering a whole-number opening stock
/// count — typing directly in the number field also works.
class StockStepper extends StatelessWidget {
  const StockStepper({required this.controller, super.key});

  final TextEditingController controller;

  void _adjust(int delta) {
    final current = int.tryParse(controller.text) ?? 0;
    final next = (current + delta).clamp(0, 999999);
    controller.text = next.toString();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      height: 50,
      padding: const EdgeInsets.all(AppDimens.p4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppRadius.medium,
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          _StepButton(
            icon: Icons.remove_rounded,
            backgroundColor: colorScheme.surfaceContainerHighest,
            foregroundColor: colorScheme.onSurface,
            onTap: () => _adjust(-1),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: AppTextStyles.headline.copyWith(
                color: colorScheme.onSurface,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          _StepButton(
            icon: Icons.add_rounded,
            backgroundColor: colorScheme.secondaryContainer,
            foregroundColor: colorScheme.onSecondaryContainer,
            onTap: () => _adjust(1),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: AppRadius.normal,
      child: InkWell(
        borderRadius: AppRadius.normal,
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: foregroundColor),
        ),
      ),
    );
  }
}
