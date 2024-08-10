import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracking_app/core/enums/bloc_states.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/data/model/countries_flag.dart';
import 'package:time_tracking_app/data/model/country_city.dart';
import 'package:time_tracking_app/domain/usecases/location_usecases.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationLoadingState()) {
    on<LocationEvent>(_init);
  }

  void _init(LocationEvent event, Emitter<LocationState> emit) async {
    emit(LocationLoadingState());

    if (event is GetCountriesEvent) {
      try {
        dynamic response =
            await Injector.resolve<LocationUseCase>().fetchAllCountries();

        final countriesFlag = CountriesFlag.fromJson(response);

        emit(CountriesLoadedState(
          countriesFlags: countriesFlag,
        ));
      } catch (e) {
        if (e is DioException) {
          emit(LocationErrorState(error: '${e.error}'));
          return;
        }
        emit(LocationErrorState(error: '$e'));
      }
    }

    if (event is GetCitiesByCountryEvent) {
      try {
        dynamic response =
            await Injector.resolve<LocationUseCase>().fetchCitiesByCountry(
          countryName: event.countryName,
        );

        final cities = CitiesByCountry.fromJson(response);

        emit(CitiesLoadedState(
          citiesByCountryName: cities,
        ));
      } catch (e) {
        if (e is DioException) {
          emit(LocationErrorState(error: '${e.error}'));
          return;
        }
        emit(LocationErrorState(error: '$e'));
      }
    }
  }
}
