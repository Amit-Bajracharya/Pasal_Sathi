import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasal_sathi/src/core/routes/app_router.gr.dart';
import 'package:pasal_sathi/src/core/routes/guards/auth_guards.dart';


final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});


@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AuthRoute.page,
          initial: true,
          guards: [guestGuard],
        ),
        AutoRoute(
          page: HomeRoute.page,
          guards: [authGuard],
        ),
      ];
}
