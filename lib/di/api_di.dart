import 'package:get_it/get_it.dart';
import 'package:music_app/features/data/remote/api/image_api_provider.dart';

class ApiDi {
  ApiDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerLazySingleton<ImageApiProvider>(
        () => ImageApiProviderImpl(injector()));
  }
}
