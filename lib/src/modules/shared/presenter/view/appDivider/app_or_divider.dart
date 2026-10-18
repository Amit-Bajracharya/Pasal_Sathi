import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

class AppOrDivider extends StatelessWidget {
  const AppOrDivider({this.label = 'OR', super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColor.neutralSwatch.shade200;
    return Row(
      children: [
        Expanded(child: Divider(color: borderColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.p12),
          child: AppText(
            label,
            fontSize: AppDimens.p12,
            fontWeight: FontWeight.w700,
            color: AppColor.neutralSwatch.shade400,
          ),
        ),
        Expanded(child: Divider(color: borderColor)),
      ],
    );
  }
}
