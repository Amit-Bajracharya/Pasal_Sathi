import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appScaffold/app_scaffold_widget.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';

@RoutePage()
class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: Center(
        child: AppText('Splash Screen'),
      ),
    );
  }
}