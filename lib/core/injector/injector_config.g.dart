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
      ..registerSingleton((c) => TaskUseCase(c<TaskAbstract>()))
      ..registerSingleton((c) => CommentUseCase(c<CommentAbstract>()))
      ..registerSingleton((c) => LocalDataUseCase(c<LocalDataAbstract>()));
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<TaskAbstract>(
          (c) => TaskRepo(c<TaskRemoteDataSource>()))
      ..registerSingleton<CommentAbstract>(
          (c) => CommentsRepo(c<CommentRemoteDatasource>()))
      ..registerSingleton<LocalDataAbstract>(
          (c) => LocalDataRepo(c<AppLocalDatasource>()));
  }

  @override
  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => TaskRemoteDataSource())
      ..registerSingleton((c) => CommentRemoteDatasource())
      ..registerSingleton((c) => AppLocalDatasource(c<LocalStorageService>()));
  }

  @override
  void _configureServices() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton<LocalStorageService>(
        (c) => AppLocalStorageService());
  }

  @override
  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => DioClient());
  }
}
