part of 'location_bloc.dart';

abstract class LocationEvent {}

class GetCountriesEvent extends LocationEvent {}

class GetCitiesByCountryEvent extends LocationEvent {
  final String countryName;

  GetCitiesByCountryEvent({
    required this.countryName,
  });
}
