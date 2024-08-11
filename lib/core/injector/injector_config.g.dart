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
      ..registerSingleton((c) => TaskUseCase(c<TaskAbstract>()))
      ..registerSingleton((c) => CommentUseCase(c<CommentAbstract>()));
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<SectionAbstract>((c) =>
          SectionRepo(sectionRemoteDataSource: c<SectionRemoteDataSource>()))
      ..registerSingleton<TaskAbstract>(
          (c) => TaskRepo(c<TaskRemoteDataSource>()))
      ..registerSingleton<CommentAbstract>(
          (c) => CommentsRepo(c<CommentRemoteDatasource>()));
  }

  @override
  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => SectionRemoteDataSource())
      ..registerSingleton((c) => TaskRemoteDataSource())
      ..registerSingleton((c) => CommentRemoteDatasource());
  }

  @override
  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => DioClient());
  }
}
