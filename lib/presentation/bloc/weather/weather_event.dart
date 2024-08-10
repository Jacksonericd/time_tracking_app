part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class WeatherEventByCity extends WeatherEvent {
  final String cityName;

  WeatherEventByCity({
    required this.cityName,
  });
}
