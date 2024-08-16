part of 'theme_cubit.dart';

abstract class ThemeState {}

class ThemeLoadedState extends ThemeState {
  final String themeMode;

  ThemeLoadedState({required this.themeMode});
}
