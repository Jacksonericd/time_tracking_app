import 'package:time_tracking_app/domain/repo_abstract/weather_abstract.dart';

class WeatherUseCase {
  final WeatherAbstract weatherAbstract;

  WeatherUseCase(this.weatherAbstract);

  Future<dynamic> fetchWeatherByLocation({required String cityName}) =>
      weatherAbstract.fetchWeatherByLocation(cityName: cityName);
}
