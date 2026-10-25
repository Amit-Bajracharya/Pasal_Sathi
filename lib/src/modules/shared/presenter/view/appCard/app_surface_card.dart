import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';

/// Tonal elevation levels from DESIGN.md's "Elevation & Depth" section.
enum AppCardElevation { level1, level2, level3 }

/// A rounded, shadowed container for cards and list surfaces — the shared
/// "white card" shape used across stat cards, list rows, and tiles.
class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    required this.child,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(AppDimens.p16),
    this.borderRadius,
    this.elevation = AppCardElevation.level1,
    this.border,
    super.key,
  });

  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry? borderRadius;
  final AppCardElevation elevation;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(AppDimens.p16),
        border: border,
        boxShadow: [_shadowFor(elevation)],
      ),
      child: child,
    );
  }

  BoxShadow _shadowFor(AppCardElevation level) {
    switch (level) {
      case AppCardElevation.level1:
        return BoxShadow(
          color: const Color(0xFF18221D).withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        );
      case AppCardElevation.level2:
        return BoxShadow(
          color: const Color(0xFF18221D).withValues(alpha: 0.08),
          blurRadius: 14,
          offset: const Offset(0, 4),
        );
      case AppCardElevation.level3:
        return BoxShadow(
          color: const Color(0xFF18221D).withValues(alpha: 0.07),
          blurRadius: 16,
          offset: const Offset(0, -4),
        );
    }
  }
}
