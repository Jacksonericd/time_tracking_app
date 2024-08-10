part of 'location_bloc.dart';

abstract class LocationState {
  final BlocStates blocStates;
  final String? message;
  final CountriesFlag? countriesFlag;
  final CitiesByCountry? citiesByCountry;

  LocationState({
    required this.blocStates,
    this.message,
    this.countriesFlag,
    this.citiesByCountry,
  });
}

class LocationLoadingState extends LocationState {
  LocationLoadingState() : super(blocStates: BlocStates.loading);
}

class CountriesLoadedState extends LocationState {
  final CountriesFlag countriesFlags;

  CountriesLoadedState({required this.countriesFlags})
      : super(
          blocStates: BlocStates.loaded,
          countriesFlag: countriesFlags,
        );
}

class CitiesLoadedState extends LocationState {
  final CitiesByCountry citiesByCountryName;

  CitiesLoadedState({required this.citiesByCountryName})
      : super(
          blocStates: BlocStates.loaded,
          citiesByCountry: citiesByCountryName,
        );
}

class LocationErrorState extends LocationState {
  final String error;

  LocationErrorState({required this.error})
      : super(
          blocStates: BlocStates.error,
          message: error,
        );
}
