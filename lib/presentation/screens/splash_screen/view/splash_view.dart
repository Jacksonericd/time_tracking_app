import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_tracking_app/core/constants/image_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_name.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/asset_image.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    navigateAfterDelay(context);

    return AppScaffold(hideAppBar: true, scaffoldBody: splashScreen);
  }

  Widget get appLogo => const AssetImageWidget(
        assetPath: ImageConstants.appIconPng,
        boxFit: BoxFit.cover,
        height: 130,
        width: 130,
      );

  Widget get splashScreen => Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appLogo,
                const AppName(),
              ],
            ),
          ),
        ],
      );

  void navigateAfterDelay(BuildContext context) async {
    await Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context)
            .pushReplacementNamed(RouteConstants.dashboardPath));
  }
}
