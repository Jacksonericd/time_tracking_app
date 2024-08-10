import 'package:time_tracking_app/core/constants/api_constants.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/network/dio_client.dart';

class TaskRemoteDataSource {
  final dioClient = Injector.resolve<DioClient>().dioNetwork;

  Future getTasksByProjectAndSection(
      {required String projectId, required String sectionId}) async {
    final url =
        '${ApiConstants.tasksUrl}tasks?$projectId&section_id=$sectionId';

    final resp = await dioClient.get(
      url,
    );

    return resp.data;
  }

  Future<dynamic> createTask({required Map inputData}) async {
    const url = ApiConstants.tasksUrl;

    final resp = await dioClient.post(
      url,
      data: inputData,
    );

    return resp.data;
  }

  Future<dynamic> updateTask(
      {required String taskId, required Map inputData}) async {
    final url = '${ApiConstants.tasksUrl}/$taskId';

    final resp = await dioClient.post(
      url,
      data: inputData,
    );

    return resp.data;
  }

  Future<dynamic> closeTask({required String taskId}) async {
    final url = '${ApiConstants.tasksUrl}/$taskId';

    final resp = await dioClient.post(
      url,
    );

    return resp.data;
  }
}
