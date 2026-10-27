// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:pasal_sathi/src/modules/auth/view/auth_view.dart' as _i3;
import 'package:pasal_sathi/src/modules/home/view/home_view.dart' as _i4;
import 'package:pasal_sathi/src/modules/products/view/add_product_view.dart'
    as _i1;
import 'package:pasal_sathi/src/modules/sales/view/add_sale_view.dart' as _i2;
import 'package:pasal_sathi/src/modules/splash_screen/splash_screen.dart'
    as _i5;

/// generated route for
/// [_i1.AddProductView]
class AddProductRoute extends _i6.PageRouteInfo<void> {
  const AddProductRoute({List<_i6.PageRouteInfo>? children})
    : super(AddProductRoute.name, initialChildren: children);

  static const String name = 'AddProductRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddProductView();
    },
  );
}

/// generated route for
/// [_i2.AddSaleView]
class AddSaleRoute extends _i6.PageRouteInfo<void> {
  const AddSaleRoute({List<_i6.PageRouteInfo>? children})
    : super(AddSaleRoute.name, initialChildren: children);

  static const String name = 'AddSaleRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddSaleView();
    },
  );
}

/// generated route for
/// [_i3.AuthView]
class AuthRoute extends _i6.PageRouteInfo<void> {
  const AuthRoute({List<_i6.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.AuthView();
    },
  );
}

/// generated route for
/// [_i4.HomeView]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeView();
    },
  );
}

/// generated route for
/// [_i5.SplashScreenView]
class SplashScreenRoute extends _i6.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i6.PageRouteInfo>? children})
    : super(SplashScreenRoute.name, initialChildren: children);

  static const String name = 'SplashScreenRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.SplashScreenView();
    },
  );
}
