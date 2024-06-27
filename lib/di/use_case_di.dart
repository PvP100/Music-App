import 'package:get_it/get_it.dart';
import 'package:music_app/features/domain/usecases/logout.dart';

import '../features/domain/usecases/domain_use_cases.dart';

class UseCaseDi {
  UseCaseDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerLazySingleton(() => LoginUseCase(injector()));
    injector.registerLazySingleton(() => Logout(injector()));
    injector.registerLazySingleton(() => GetCategories(injector()));
    injector.registerLazySingleton(() => GetTrack(injector()));
    injector.registerLazySingleton(() => GetProfile(injector()));
    injector.registerLazySingleton(() => GetHomeMenu(injector()));
    injector.registerLazySingleton(() => GetAlbumPlaylist(injector()));
    injector.registerLazySingleton(() => SearchAll(injector()));
    injector.registerLazySingleton(() => GetArtist(injector()));
    injector.registerLazySingleton(() => Register(injector()));
  }
}
