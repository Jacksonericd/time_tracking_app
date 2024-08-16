import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/constants/string_constants.dart';

import 'package:time_tracking_app/core/utils/shared_prefernces_utils.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeLoadedState(
            themeMode: PreferenceUtils.keyContains(themeMode)
                ? PreferenceUtils.getString(themeMode) ?? StringConstants.light
                : StringConstants.light));

  static const String themeMode = 'theme-mode';

  setThemeMode(String themeMode) {
    if (state is ThemeLoadedState) {
      _storeThemeLocally(themeMode.toString());

      emit(ThemeLoadedState(themeMode: themeMode.toString()));
    }
  }

  String getCurrentThemeMode() {
    if (state is ThemeLoadedState) {
      final loadedState = state as ThemeLoadedState;
      return loadedState.themeMode.toString();
    }
    return StringConstants.light;
  }

  Future<void> _storeThemeLocally(String value) async {
    if (PreferenceUtils.keyContains(themeMode)) {
      PreferenceUtils.removeKey(themeMode);
    }
    PreferenceUtils.setString(themeMode, value);
  }
}
