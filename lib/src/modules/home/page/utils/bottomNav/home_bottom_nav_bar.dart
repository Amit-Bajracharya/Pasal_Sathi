import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

class _NavItem {
  const _NavItem(this.icon, this.label);
  final IconData icon;
  final String label;
}

/// The fixed 4-tab bottom bar: Home, Products, Sales, Analysis.
class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({required this.currentIndex, this.onTap, super.key});

  final int currentIndex;
  final ValueChanged<int>? onTap;

  static const _items = [
    _NavItem(Icons.home_rounded, 'Home'),
    _NavItem(Icons.inventory_2_outlined, 'Products'),
    _NavItem(Icons.receipt_long_outlined, 'Sales'),
    _NavItem(Icons.bar_chart_rounded, 'Analysis'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimens.p20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12191C1C),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: AppDimens.p10),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final active = index == currentIndex;
            final item = _items[index];
            return InkWell(
              onTap: () => onTap?.call(index),
              borderRadius: BorderRadius.circular(AppDimens.p12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.p12,
                  vertical: AppDimens.p4,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.p16,
                        vertical: AppDimens.p4,
                      ),
                      decoration: BoxDecoration(
                        color: active
                            ? AppColor.homeSuccessContainer
                            : Colors.transparent,
                        borderRadius: AppRadius.pill,
                      ),
                      child: Icon(
                        item.icon,
                        size: 22,
                        color: active
                            ? AppColor.homePrimary
                            : AppColor.homeOnSurfaceMuted,
                      ),
                    ),
                    AppSpacing.h4,
                    AppText(
                      item.label,
                      style: AppTextStyles.body,
                      color: active
                          ? AppColor.homePrimary
                          : AppColor.homeOnSurfaceMuted,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
