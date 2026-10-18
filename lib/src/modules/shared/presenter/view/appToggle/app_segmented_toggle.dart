import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// A pill-shaped segmented control, e.g. for switching between
/// "Login" / "Sign Up" or similar two-or-more-way toggles.
class AppSegmentedToggle extends StatelessWidget {
  const AppSegmentedToggle({
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.all(AppDimens.p4),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.12),
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        children: List.generate(options.length, (index) {
          final active = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: AppDimens.p11),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? primary : Colors.transparent,
                  borderRadius: AppRadius.pill,
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: primary.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: AppText(
                  options[index],
                  fontSize: AppDimens.p14,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                  color: active ? Colors.white : AppColor.neutralSwatch.shade600,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
