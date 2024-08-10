// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  @override
  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => WeatherUseCase(c<WeatherAbstract>()))
      ..registerSingleton((c) => LocationUseCase(c<LocationAbstract>()));
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<WeatherAbstract>((c) =>
          WeatherRepo(weatherRemoteDataSource: c<WeatherRemoteDataSource>()))
      ..registerSingleton<LocationAbstract>((c) => LocationRepo(
          locationRemoteDataSource: c<LocationRemoteDataSource>()));
  }

  @override
  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => WeatherRemoteDataSource())
      ..registerSingleton((c) => LocationRemoteDataSource());
  }

  @override
  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => DioClient());
  }
}
