import 'package:time_tracking_app/data/datasources/remote/weather_remote_datasource.dart';
import 'package:time_tracking_app/domain/repo_abstract/weather_abstract.dart';

class WeatherRepo extends WeatherAbstract {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepo({
    required this.weatherRemoteDataSource,
  });

  @override
  Future fetchWeatherByLocation({required String cityName}) {
    return weatherRemoteDataSource.fetchWeatherByLocation(
      cityName: cityName,
    );
  }
}
