import 'package:time_tracking_app/core/constants/api_constants.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/network/dio_client.dart';

class LocationRemoteDataSource {
  final dioClient = Injector.resolve<DioClient>().dioNetwork;

  Future fetchAllCountries() async {
    const url = '${ApiConstants.countryBaseUrl}${ApiConstants.countriesUrl}';

    final resp = await dioClient.get(
      url,
    );

    return resp.data;
  }

  Future fetchCitiesByCountry({required String countryName}) async {
    final url =
        '${ApiConstants.countryBaseUrl}${ApiConstants.citiesUrl}/q?country=$countryName';

    final resp = await dioClient.get(
      url,
    );

    return resp.data;
  }
}
