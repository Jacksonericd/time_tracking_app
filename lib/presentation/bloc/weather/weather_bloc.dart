import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/enums/bloc_states.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/data/model/weather_response.dart';
import 'package:time_tracking_app/domain/usecases/weather_usecases.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherDataLoadingState()) {
    on<WeatherEvent>(_init);
  }

  void _init(WeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherDataLoadingState());

    if (event is WeatherEventByCity) {
      try {
        dynamic response =
            await Injector.resolve<WeatherUseCase>().fetchWeatherByLocation(
          cityName: event.cityName,
        );

        final weatherResponse = WeatherResponse.fromJson(response);

        emit(WeatherDataLoadedState(
          weatherResponseData: weatherResponse,
        ));
      } catch (e) {
        if(e is DioException) {
          print('${e.error}');
          emit(WeatherDataErrorState(error: '${e.error}'));
          return;
        }
        print(e);
        emit(WeatherDataErrorState(error: '$e'));
      }
    }
  }
}
