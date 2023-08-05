import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/features/data/base/base_dio.dart';

import '../config/config.dart';

class NetworkDi {
  NetworkDi._();

  static Future<void> init(GetIt injector,
      {required BuildMode buildMode}) async {
    GetIt.instance.registerSingleton<NetWorkMode>(NetWorkMode(mode: buildMode));
    GetIt.instance.registerSingleton<CustomInterceptors>(CustomInterceptors());
    GetIt.instance.registerSingleton<Dio>(Dio(BaseOptions(
      baseUrl: injector<NetWorkMode>().baseUrl,
      headers: {
        'content-Type': Headers.jsonContentType,
        'Authorization': 'Client-ID CZlv3UujPt65aSoYC11eYKg1njSEclZFPTFRqlqJZP4'
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ))
      ..interceptors.add(injector<CustomInterceptors>()));
    GetIt.instance.registerSingleton<IBaseDio>(BaseDio(injector()));
  }
}
