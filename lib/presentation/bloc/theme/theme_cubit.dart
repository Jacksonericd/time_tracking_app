import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLoadedState(themeMode: ThemeMode.system));

  toggleThemeMode() {
    if (state is ThemeLoadedState) {
      final loadedState = state as ThemeLoadedState;

      emit(ThemeLoadedState(themeMode: loadedState.themeMode));
    }
  }

  ThemeMode getCurrentThemeMode() {
    if (state is ThemeLoadedState) {
      final loadedState = state as ThemeLoadedState;
      return loadedState.themeMode;
    }
    return ThemeMode.system;
  }
}
