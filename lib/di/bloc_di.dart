import 'package:get_it/get_it.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';

class BlocDi {
  BlocDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerLazySingleton(() => AppBloc());
    injector.registerFactory(() => SplashBloc());
    injector.registerFactory(() => HomeBloc(injector()));
    injector.registerFactory(() => LoginBloc());
  }
}
