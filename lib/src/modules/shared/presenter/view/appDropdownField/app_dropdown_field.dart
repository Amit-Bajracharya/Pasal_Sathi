import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// A labeled dropdown field styled to match [AppTextField] — same border,
/// radius, and focus treatment, for forms that need a select instead of
/// free text (category, supplier, etc).
class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    required this.labelText,
    required this.value,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    this.isMandatory = false,
    super.key,
  });

  final String labelText;
  final T value;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final ValueChanged<T?> onChanged;
  final bool isMandatory;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: labelText,
            style: AppTextStyles.label.copyWith(color: colorScheme.onSurface),
            children: isMandatory
                ? [
                    TextSpan(
                      text: ' *',
                      style: AppTextStyles.label.copyWith(
                        color: colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                : const [],
          ),
        ),
        AppSpacing.h6,
        DropdownButtonFormField<T>(
          initialValue: value,
          icon: Icon(Icons.unfold_more_rounded, color: colorScheme.outline),
          style: AppTextStyles.body.copyWith(color: colorScheme.onSurface),
          dropdownColor: colorScheme.surface,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimens.p14,
              vertical: AppDimens.p14,
            ),
            border: OutlineInputBorder(
              borderRadius: AppRadius.medium,
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.medium,
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.medium,
              borderSide: BorderSide(color: colorScheme.primary),
            ),
          ),
          items: [
            for (final item in items)
              DropdownMenuItem(
                value: item,
                child: AppText(itemLabelBuilder(item)),
              ),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
