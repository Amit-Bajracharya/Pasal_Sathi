import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasal_sathi/src/core/routes/app_router.gr.dart';


final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});


@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashScreenRoute.page,
          initial: true,
        ),
      ];
}
