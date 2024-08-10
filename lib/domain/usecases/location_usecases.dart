import '../repo_abstract/location_abstract.dart';

class LocationUseCase {
  final LocationAbstract locationAbstract;

  LocationUseCase(this.locationAbstract);

  Future<dynamic> fetchAllCountries() => locationAbstract.fetchAllCountries();

  Future<dynamic> fetchCitiesByCountry({
    required String countryName,
  }) =>
      locationAbstract.fetchCitiesByCountry(
        countryName: countryName,
      );
}
