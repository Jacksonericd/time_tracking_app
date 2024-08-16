part of 'theme_cubit.dart';

abstract class ThemeState {}

class ThemeLoadedState extends ThemeState {
  final ThemeMode themeMode;

  ThemeLoadedState({required this.themeMode});
}
