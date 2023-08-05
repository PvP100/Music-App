import 'package:dio/dio.dart';
import 'package:music_app/config/logger.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logi.d('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logi.d(
        'RESPONSE[${response.statusCode}] => PATH: ${response.realUri.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logi.e(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.response?.realUri.path}');
    return super.onError(err, handler);
  }
}
