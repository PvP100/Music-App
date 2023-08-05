import 'package:get_it/get_it.dart';
import 'package:music_app/features/domain/usecases/get_product.dart';

class UseCaseDi {
  UseCaseDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerLazySingleton(() => GetRandomImage(injector()));
  }
}
