import 'package:time_tracking_app/core/constants/api_constants.dart';
import 'package:time_tracking_app/core/injector/injector.dart';
import 'package:time_tracking_app/core/network/dio_client.dart';

class CommentRemoteDatasource {
  final dioClient = Injector.resolve<DioClient>().dioNetwork;

  Future<dynamic> getCommentsByTask({
    required String taskId,
  }) async {
    final url = '${ApiConstants.commentsUrl}?task_id=$taskId';

    final resp = await dioClient.get(
      url,
    );

    return resp.data;
  }

  Future<dynamic> getCommentById({
    required String commentId,
  }) async {
    final url = '${ApiConstants.commentsUrl}/$commentId';

    final resp = await dioClient.get(
      url,
    );

    return resp.data;
  }

  Future<dynamic> createComment({
    required Map inputData,
  }) async {
    const url = ApiConstants.commentsUrl;

    final resp = await dioClient.post(
      url,
      data: inputData,
    );

    return resp.data;
  }

  Future<dynamic> updateComment({
    required String commentId,
    required Map inputData,
  }) async {
    final url = '${ApiConstants.commentsUrl}/$commentId';

    final resp = await dioClient.post(
      url,
      data: inputData,
    );

    return resp.data;
  }

  Future<dynamic> deleteComment({
    required String commentId,
  }) async {
    final url = '${ApiConstants.commentsUrl}/$commentId';

    final resp = await dioClient.delete(
      url,
    );

    return resp.data;
  }
}
