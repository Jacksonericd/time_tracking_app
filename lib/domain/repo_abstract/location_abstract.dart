abstract class LocationAbstract {
  Future<dynamic> fetchAllCountries();

  Future<dynamic> fetchCitiesByCountry({required String countryName});
}
