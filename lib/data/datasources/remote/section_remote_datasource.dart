import 'package:time_tracking_app/core/constants/api_constants.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/network/dio_client.dart';

class SectionRemoteDataSource {
  final dioClient = Injector.resolve<DioClient>().dioNetwork;

  Future fetchAllSections({required String projectId}) async {
    final url = '${ApiConstants.sectionsUrl}?project_id=$projectId';

    final resp = await dioClient.get(
      url,
    );

    return resp.data;
  }
}
