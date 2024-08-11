import 'dart:async';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      // "Content-Type": "application/json",
      "Authorization" : "Bearer fe9fa4967f25fe964654a624ace5dcf01fd8b4c0"
    });

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw TimeoutException('Connection timed out');
      case DioExceptionType.connectionError:
      case DioExceptionType.badResponse:
        final errorMessage = err.message;
        super.onError(
            DioException(
                error: errorMessage, requestOptions: err.requestOptions),
            handler);
      case DioExceptionType.unknown:
        final errorMessage = err.response?.data['message'];

        switch (err.response?.statusCode) {
          case 400:
            super.onError(
                DioException(
                    error: errorMessage, requestOptions: err.requestOptions),
                handler);
            break;
          case 401:
            super.onError(
                DioException(
                    error: errorMessage, requestOptions: err.requestOptions),
                handler);
            break;
          case 403:
            super.onError(
                DioException(
                    error: errorMessage, requestOptions: err.requestOptions),
                handler);

            break;
          case 500:
            super.onError(
                DioException(
                    error: err.message, requestOptions: err.requestOptions),
                handler);
            break;
        }
        break;
      default:
        super.onError(err, handler);
    }
  }
}
