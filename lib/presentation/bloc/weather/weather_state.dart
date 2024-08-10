part of 'weather_bloc.dart';

abstract class WeatherState {
  final BlocStates blocStates;
  final String? message;
  final WeatherResponse? weatherResponse;

  WeatherState({
    required this.blocStates,
    this.message,
    this.weatherResponse,
  });
}

class WeatherDataLoadingState extends WeatherState {
  WeatherDataLoadingState() : super(blocStates: BlocStates.loading);
}

class WeatherDataLoadedState extends WeatherState {
  final WeatherResponse weatherResponseData;

  WeatherDataLoadedState({required this.weatherResponseData})
      : super(
          blocStates: BlocStates.loaded,
          weatherResponse: weatherResponseData,
        );
}

class WeatherDataErrorState extends WeatherState {
  final String error;

  WeatherDataErrorState({required this.error})
      : super(
          blocStates: BlocStates.error,
          message: error,
        );
}
