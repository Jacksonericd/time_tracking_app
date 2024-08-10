import 'package:time_tracking_app/data/datasources/remote/location_remote_datasource.dart';
import 'package:time_tracking_app/domain/repo_abstract/location_abstract.dart';

class LocationRepo extends LocationAbstract {
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepo({required this.locationRemoteDataSource});

  @override
  Future fetchAllCountries() async {
    return await locationRemoteDataSource.fetchAllCountries();
  }

  @override
  Future fetchCitiesByCountry({required String countryName}) async {
    return await locationRemoteDataSource.fetchCitiesByCountry(
      countryName: countryName,
    );
  }
}
