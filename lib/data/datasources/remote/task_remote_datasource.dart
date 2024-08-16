import 'dart:convert';

import 'package:time_tracking_app/core/constants/api_constants.dart';
import 'package:time_tracking_app/core/functions/common_functions.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/network/dio_client.dart';

class TaskRemoteDataSource {
  final dioClient = Injector.resolve<DioClient>().dioNetwork;

  Future getTasksByProjectId(
      {required String projectId, String? sectionId}) async {
    // final url = '${ApiConstants.tasksUrl}?$projectId&section_id=$sectionId';
    final url = '${ApiConstants.tasksUrl}?$projectId';

    final resp = await dioClient.get(
      url,
    );

    return resp.data;
  }

  Future getTasksById({
    required String taskId,
  }) async {
    final url = '${ApiConstants.tasksUrl}/$taskId';

    final resp = await dioClient.get(
      url,
    );

    return resp.data;
  }

  Future getCompletedTasksByProject({required String projectId}) async {
    final url = '${ApiConstants.tasksCompletedUrl}?$projectId';

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

  Future<dynamic> completeTask({required String taskId}) async {
    const url = ApiConstants.tasksCompleteUrl;

    final body = {
      'commands': [
        {
          "type": "item_complete",
          "uuid": "a74bfb5c-5f1d-4d14-baea-b7415446a871",
          "args": {
            "id": taskId,
            "date_completed":
                CommonFunctions.formatToRFC3339NanoUtc(DateTime.now())
          }
        }
      ]
    };

    dioClient.options.headers.addAll({
      "Content-Type": "application/x-www-form-urlencoded",
    });

    final resp = await dioClient.post(url, data: body);

    return resp.data;
  }
}
