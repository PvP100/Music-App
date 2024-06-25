import 'package:get_it/get_it.dart';

import '../features/domain/usecases/domain_use_cases.dart';

class UseCaseDi {
  UseCaseDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerLazySingleton(() => LoginUseCase(injector()));
    injector.registerLazySingleton(() => GetCategories(injector()));
    injector.registerLazySingleton(() => GetTrack(injector()));
    injector.registerLazySingleton(() => GetProfile(injector()));
    injector.registerLazySingleton(() => GetHomeMenu(injector()));
  }
}
