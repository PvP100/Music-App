import 'package:get_it/get_it.dart';
import 'package:music_app/features/domain/usecases/logout.dart';
import 'package:music_app/features/domain/usecases/update_profile.dart';

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
    injector.registerLazySingleton(() => UpdateProfile(injector()));
    injector.registerLazySingleton(() => UploadFile(injector()));
    injector.registerLazySingleton(() => LikeHaMusic(injector()));
    injector.registerLazySingleton(() => DeleteHaMusic(injector()));
  }
}
