import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// A section title row: an optional leading colored dot, bold title text,
/// and an optional trailing widget (a link, a chip) pinned to the right.
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    required this.title,
    this.titleStyle,
    this.titleColor,
    this.dotColor,
    this.trailing,
    super.key,
  });

  final String title;
  final TextStyle? titleStyle;
  final Color? titleColor;
  final Color? dotColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (dotColor != null) ...[
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
        ],
        Expanded(
          child: AppText(
            title,
            style: titleStyle,
            color: titleColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        ?trailing,
      ],
    );
  }
}
