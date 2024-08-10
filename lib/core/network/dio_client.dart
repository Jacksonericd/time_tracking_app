import 'package:dio/dio.dart';

import 'dio_interceptors.dart';

class DioClient {
  final Dio dioNetwork = Dio();

  final dioOptions = BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  );

  DioClient() {
    dioNetwork.options = dioOptions;

    dioNetwork.interceptors.add(DioInterceptor());
  }
}
