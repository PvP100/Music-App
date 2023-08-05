import 'package:get_it/get_it.dart';
import 'package:music_app/features/data/repositories/image_repository_impl.dart';
import 'package:music_app/features/domain/repositories/image_repository.dart';

class RepositoryDi {
  RepositoryDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerLazySingleton<ImageRepository>(
        () => ImageRepositoryImpl(injector()));
  }
}
