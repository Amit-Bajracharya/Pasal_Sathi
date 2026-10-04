import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';

class AppScaffoldWidget extends ConsumerWidget {
  const AppScaffoldWidget({
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.showTopDivider = true,
    this.showBottomDivider = true,
    super.key,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool showTopDivider;
  final bool showBottomDivider;
  final bool resizeToAvoidBottomInset;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(
      builder: (state) {
        return Scaffold(
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          appBar: appBar == null
              ? null
              : PreferredSize(
                  preferredSize: Size.fromHeight(
                    appBar!.preferredSize.height +
                        (showTopDivider ? AppDimens.p6 : 0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      appBar!,
                      
                    ],
                  ),
                ),

          body: body,
        
        );
      },
    );
  }
}
