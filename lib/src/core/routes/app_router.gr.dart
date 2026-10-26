// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:pasal_sathi/src/modules/auth/view/auth_view.dart' as _i2;
import 'package:pasal_sathi/src/modules/home/view/home_view.dart' as _i3;
import 'package:pasal_sathi/src/modules/products/view/add_product_view.dart'
    as _i1;
import 'package:pasal_sathi/src/modules/splash_screen/splash_screen.dart'
    as _i4;

/// generated route for
/// [_i1.AddProductView]
class AddProductRoute extends _i5.PageRouteInfo<void> {
  const AddProductRoute({List<_i5.PageRouteInfo>? children})
    : super(AddProductRoute.name, initialChildren: children);

  static const String name = 'AddProductRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddProductView();
    },
  );
}

/// generated route for
/// [_i2.AuthView]
class AuthRoute extends _i5.PageRouteInfo<void> {
  const AuthRoute({List<_i5.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthView();
    },
  );
}

/// generated route for
/// [_i3.HomeView]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeView();
    },
  );
}

/// generated route for
/// [_i4.SplashScreenView]
class SplashScreenRoute extends _i5.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i5.PageRouteInfo>? children})
    : super(SplashScreenRoute.name, initialChildren: children);

  static const String name = 'SplashScreenRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashScreenView();
    },
  );
}
