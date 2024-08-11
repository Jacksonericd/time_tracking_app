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
      ..registerSingleton((c) => SectionUseCase(c<SectionAbstract>()))
      ..registerSingleton((c) => TaskUseCase(c<TaskAbstract>()));
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<SectionAbstract>((c) =>
          SectionRepo(sectionRemoteDataSource: c<SectionRemoteDataSource>()))
      ..registerSingleton<TaskAbstract>(
          (c) => TaskRepo(c<TaskRemoteDataSource>()));
  }

  @override
  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => SectionRemoteDataSource())
      ..registerSingleton((c) => TaskRemoteDataSource());
  }

  @override
  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => DioClient());
  }
}
