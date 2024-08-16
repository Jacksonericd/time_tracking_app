import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/services/shared_preference_service/preference_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLoadedState(themeMode: ThemeMode.system));

  static const String themeMode = 'theme-mode';

  setThemeMode(ThemeMode themeMode) {
    if (state is ThemeLoadedState) {
      _storeThemeLocally(themeMode.toString());

      emit(ThemeLoadedState(themeMode: themeMode));
    }
  }

  ThemeMode getCurrentThemeMode() {
    if (state is ThemeLoadedState) {
      final loadedState = state as ThemeLoadedState;
      return loadedState.themeMode;
    }
    return ThemeMode.system;
  }

  Future<void> _storeThemeLocally(String value) async {
    await Injector.resolve<PreferenceService>().storeString(themeMode, value);
  }
}
