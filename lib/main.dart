import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/presentation/theme/app_theme.dart';

import 'core/config/app_routes.dart';
import 'core/config/navigator_key.dart';
import 'core/constants/string_constants.dart';
import 'core/injector/injector_config.dart';

void main() {
  InjectorConfig.setup();

  runApp(const TimeTrackingApp());
}

class TimeTrackingApp extends StatelessWidget {
  const TimeTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appName,
      initialRoute: RouteConstants.splashPath,
      onGenerateRoute: AppRoutes().generateRoute,
      themeMode: ThemeMode.light,
      darkTheme: CustomThemeData.darkTheme,
      theme: CustomThemeData.lightTheme,
      navigatorKey: appNavigatorKey,
    );
  }
}
