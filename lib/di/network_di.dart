import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/core/core.dart';
import 'package:music_app/features/data/base/base_dio.dart';

import '../config/config.dart';

class NetworkDi {
  NetworkDi._();

  static Future<void> init(GetIt injector) async {
    GetIt.instance.registerSingleton<NetWorkConfig>(NetWorkConfig());
    GetIt.instance.registerSingleton<CustomInterceptors>(CustomInterceptors());
    GetIt.instance.registerSingleton<Dio>(Dio(BaseOptions(
      baseUrl: injector<NetWorkConfig>().baseUrl,
      headers: {
        Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
      },
      connectTimeout: 10.seconds,
      receiveTimeout: 10.seconds,
    ))
      ..interceptors.add(injector<CustomInterceptors>()));
    GetIt.instance.registerSingleton<IBaseDio>(BaseDio(injector()));
  }
}
