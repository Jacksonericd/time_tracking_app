import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/constants/route_constants.dart';
import 'package:time_tracking_app/presentation/bloc/task/task_bloc.dart';
import 'package:time_tracking_app/presentation/bloc/task_cubit/task_cubit.dart';
import 'package:time_tracking_app/presentation/bloc/theme/theme_cubit.dart';
import 'package:time_tracking_app/presentation/theme/app_theme.dart';

import 'core/config/app_routes.dart';
import 'core/config/navigator_key.dart';
import 'core/constants/string_constants.dart';
import 'core/injector/injector.dart';
import 'core/injector/injector_config.dart';
import 'core/services/shared_preference_service/preference_service.dart';

void main() {
  InjectorConfig.setup();

  runApp(const TimeTrackingApp());
}

class TimeTrackingApp extends StatelessWidget {
  const TimeTrackingApp({super.key});

  Future<ThemeMode> _getThemeModeStored() async {
    final mode =
        await Injector.resolve<PreferenceService>().getString('theme-mode');

    return mode != null ? mode as ThemeMode : ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getThemeModeStored(),
      builder: (context, snapshot) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => TaskBloc()),
            BlocProvider(
                create: (context) => TaskCubit()..setCubitDataFromApi()),
            BlocProvider(
                create: (context) => ThemeCubit()
                  ..setThemeMode(snapshot.data ?? ThemeMode.system))
          ],
          child: BlocBuilder<TaskCubit, TaskCubitState>(
            builder: (context, state) {
              return BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return MaterialApp(
                    title: StringConstants.appName,
                    initialRoute: RouteConstants.splashPath,
                    onGenerateRoute: AppRoutes().generateRoute,
                    themeMode: ThemeMode.light,
                    darkTheme: CustomThemeData.darkTheme,
                    theme: CustomThemeData.lightTheme,
                    navigatorKey: appNavigatorKey,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
