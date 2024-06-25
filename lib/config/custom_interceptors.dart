import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/config/logger.dart';
import 'package:music_app/core/constants/api_path_constants.dart';
import 'package:music_app/core/constants/shared_preferences_constants.dart';
import 'package:music_app/features/data/preference/ha_music_shared_preference.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logi.d('REQUEST[${options.method}] => PATH: ${options.path}');
    if (options.path != ApiPathConstants.login) {
      options.headers['Authorization'] =
          "Bearer ${GetIt.I.get<HaMusicSharedPreference>().get<String>(SharedPreferencesConstants.appToken)}";
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logi.d(
        'RESPONSE[${response.statusCode}] => PATH: ${response.realUri.path} \n Response => ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logi.e('ERROR[${err.response?.statusCode}] => PATH: ${err.response}');
    return super.onError(err, handler);
  }
}
