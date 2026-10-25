import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appChip/app_pill_chip.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

/// Top-of-screen shop identity row: avatar, shop name, owner greeting,
/// open/closed status, and a notification bell.
class ShopHeader extends StatelessWidget {
  const ShopHeader({
    required this.shopName,
    required this.ownerName,
    required this.isOpen,
    this.hasNotification = false,
    this.onNotificationTap,
    this.onLogoutTap,
    super.key,
  });

  final String shopName;
  final String ownerName;
  final bool isOpen;
  final bool hasNotification;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColor.homePrimary,
            borderRadius: BorderRadius.circular(AppDimens.p12),
          ),
          child: const Icon(Icons.storefront_rounded, color: Colors.white),
        ),
        AppSpacing.w12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                shopName,
                style: AppTextStyles.title,
                color: AppColor.homeOnSurface,
              ),
              AppSpacing.h4,
              Row(
                children: [
                  Flexible(
                    child: AppText(
                      'Namaste, $ownerName \u{1F44B}',
                      style: AppTextStyles.bodySmall,
                      color: AppColor.homeOnSurfaceMuted,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AppSpacing.w8,
                  AppPillChip(
                    label: isOpen ? 'Open' : 'Closed',
                    backgroundColor: isOpen
                        ? AppColor.homeSuccessContainer
                        : AppColor.homeDangerContainer,
                    foregroundColor: isOpen
                        ? AppColor.homeOnSuccessContainer
                        : AppColor.homeOnDangerContainer,
                    dot: true,
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSpacing.w8,
        _NotificationButton(
          hasNotification: hasNotification,
          onTap: onNotificationTap,
        ),
        AppSpacing.w8,
        _LogoutButton(onTap: onLogoutTap),
      ],
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({required this.hasNotification, this.onTap});

  final bool hasNotification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surface,
      shape: const CircleBorder(),
      elevation: 1,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: AppColor.homeOnSurface,
              ),
              if (hasNotification)
                const Positioned(
                  top: 10,
                  right: 12,
                  child: _NotificationDot(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.surface,
      shape: const CircleBorder(),
      elevation: 1,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 44,
          height: 44,
          child: Icon(Icons.logout_rounded, color: AppColor.homeOnSurface),
        ),
      ),
    );
  }
}

class _NotificationDot extends StatelessWidget {
  const _NotificationDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: AppColor.homeDanger,
        shape: BoxShape.circle,
      ),
    );
  }
}
