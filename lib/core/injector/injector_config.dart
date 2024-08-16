import 'package:kiwi/kiwi.dart';
import 'package:time_tracking_app/core/network/dio_client.dart';
import 'package:time_tracking_app/core/services/local_storage/app_local_storage_service.dart';
import 'package:time_tracking_app/core/services/local_storage/local_storage_service.dart';
import 'package:time_tracking_app/data/datasources/local/app_local_datasource.dart';
import 'package:time_tracking_app/data/datasources/remote/comment_remote_datasource.dart';
import 'package:time_tracking_app/data/datasources/remote/task_remote_datasource.dart';
import 'package:time_tracking_app/data/repositories/comments_repo.dart';
import 'package:time_tracking_app/data/repositories/local_data_repo.dart';
import 'package:time_tracking_app/data/repositories/task_repo.dart';
import 'package:time_tracking_app/domain/repo_abstract/comment_abstract.dart';
import 'package:time_tracking_app/domain/repo_abstract/local_data_abstract.dart';
import 'package:time_tracking_app/domain/repo_abstract/task_abstract.dart';
import 'package:time_tracking_app/domain/usecases/comment_usecase.dart';
import 'package:time_tracking_app/domain/usecases/local_data_usecase.dart';
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
    _configureServices();
    _configureCommon();
  }

  // ============ USECASES ============
  @Register.singleton(TaskUseCase)
  @Register.singleton(CommentUseCase)
  @Register.singleton(LocalDataUseCase)
  void _configureUseCases();

  // ============ REPOSITORIES ============
  @Register.singleton(TaskAbstract, from: TaskRepo)
  @Register.singleton(CommentAbstract, from: CommentsRepo)
  @Register.singleton(LocalDataAbstract, from: LocalDataRepo)
  void _configureRepositories();

  // ============ REMOTE DATASOURCES ============
  @Register.singleton(TaskRemoteDataSource)
  @Register.singleton(CommentRemoteDatasource)
  @Register.singleton(AppLocalDatasource)
  void _configureRemoteDataSources();

  // ============ SERVICES ============
  @Register.singleton(LocalStorageService, from: AppLocalStorageService)
  void _configureServices();

  // ============ NETWORK ============
  @Register.singleton(DioClient)
  void _configureCommon();
}
