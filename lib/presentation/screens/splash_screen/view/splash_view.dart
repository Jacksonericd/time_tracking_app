import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_tracking_app/core/constants/image_constants.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_name.dart';
import 'package:time_tracking_app/core/presentation/widgets/app_scaffold.dart';
import 'package:time_tracking_app/core/presentation/widgets/asset_image.dart';
import 'package:time_tracking_app/domain/usecases/local_data_usecase.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    navigateAfterDelay(context);

    return AppScaffold(hideAppBar: true, scaffoldBody: splashScreen);
  }

  Widget get appLogo => ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: const AssetImageWidget(
          assetPath: ImageConstants.appIconPng,
          boxFit: BoxFit.cover,
          height: 130,
          width: 130,
        ),
      );

  Widget get spacingBetween => const SizedBox(
        height: 20,
      );

  Widget get splashScreen => Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appLogo,
                spacingBetween,
                const AppName(),
              ],
            ),
          ),
        ],
      );

  void navigateAfterDelay(BuildContext context) async {
    await Injector.resolve<LocalDataUseCase>().initDatabase();

    await Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context)
            .pushReplacementNamed(RouteConstants.dashboardPath));
  }
}
