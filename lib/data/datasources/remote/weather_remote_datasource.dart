import 'package:time_tracking_app/core/constants/api_constants.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/network/dio_client.dart';

class WeatherRemoteDataSource {
  final dioClient = Injector.resolve<DioClient>().dioNetwork;

  Future fetchWeatherByLocation({required String cityName}) async {
    final url =
        '${ApiConstants.baseUrl}${ApiConstants.weatherApiUrl}?q=$cityName&appid=${ApiConstants.weatherApiKey}&units=metric';

    final resp = await dioClient.get(
      url,
    );

    return resp.data;
  }
}
