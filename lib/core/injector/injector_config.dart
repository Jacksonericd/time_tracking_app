import 'package:kiwi/kiwi.dart';
import 'package:time_tracking_app/core/network/dio_client.dart';
import 'package:time_tracking_app/data/datasources/remote/location_remote_datasource.dart';
import 'package:time_tracking_app/data/datasources/remote/weather_remote_datasource.dart';
import 'package:time_tracking_app/data/repositories/location_repo.dart';
import 'package:time_tracking_app/data/repositories/weather_repo.dart';
import 'package:time_tracking_app/domain/repo_abstract/location_abstract.dart';
import 'package:time_tracking_app/domain/repo_abstract/weather_abstract.dart';
import 'package:time_tracking_app/domain/usecases/location_usecases.dart';
import 'package:time_tracking_app/domain/usecases/weather_usecases.dart';

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
  @Register.singleton(WeatherUseCase)
  @Register.singleton(LocationUseCase)
  void _configureUseCases();

  // ============ REPOSITORIES ============
  @Register.singleton(WeatherAbstract, from: WeatherRepo)
  @Register.singleton(LocationAbstract, from: LocationRepo)
  void _configureRepositories();

  // ============ REMOTE DATASOURCES ============
  @Register.singleton(WeatherRemoteDataSource)
  @Register.singleton(LocationRemoteDataSource)
  void _configureRemoteDataSources();

  // ============ NETWORK ============
  @Register.singleton(DioClient)
  void _configureCommon();
}
