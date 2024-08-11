import 'package:kiwi/kiwi.dart';
import 'package:time_tracking_app/core/network/dio_client.dart';
import 'package:time_tracking_app/data/datasources/remote/section_remote_datasource.dart';
import 'package:time_tracking_app/data/datasources/remote/task_remote_datasource.dart';
import 'package:time_tracking_app/data/repositories/section_repo.dart';
import 'package:time_tracking_app/data/repositories/task_repo.dart';
import 'package:time_tracking_app/domain/repo_abstract/section_abstract.dart';
import 'package:time_tracking_app/domain/repo_abstract/task_abstract.dart';
import 'package:time_tracking_app/domain/usecases/section_usecase.dart';
import 'package:time_tracking_app/domain/usecases/task_usecase.dart';

part 'injector_config.g.dart';

abstract class InjectorConfig {
  static KiwiContainer container = KiwiContainer();

  static void setup() {
    container = KiwiContainer();
    _$InjectorConfig()._configure();
  }

  // ignore: type_annotate_public_apis
  static final resolve = container.resolve;

  void _configure() {
    _configureUseCases();
    _configureRepositories();
    _configureRemoteDataSources();
    _configureCommon();
  }

  // ============ USECASES ============
  @Register.singleton(SectionUseCase)
  @Register.singleton(TaskUseCase)
  void _configureUseCases();

  // ============ REPOSITORIES ============
  @Register.singleton(SectionAbstract, from: SectionRepo)
  @Register.singleton(TaskAbstract, from: TaskRepo)
  void _configureRepositories();

  // ============ REMOTE DATASOURCES ============
  @Register.singleton(SectionRemoteDataSource)
  @Register.singleton(TaskRemoteDataSource)
  void _configureRemoteDataSources();

  // ============ NETWORK ============
  @Register.singleton(DioClient)
  void _configureCommon();
}
