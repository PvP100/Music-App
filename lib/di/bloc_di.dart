import 'package:get_it/get_it.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';

class BlocDi {
  BlocDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerLazySingleton(() => AppBloc());
    injector.registerFactory(() => SplashBloc());
    injector.registerFactory(() => HomeBloc(injector()));
    injector.registerFactory(() => LoginBloc());
    injector.registerFactory(() => LoginOrRegisterBloc());
    injector.registerFactory(() => ChangePasswordBloc());
    injector.registerFactory(() => ForgotPasswordBloc());
    injector.registerFactory(() => RegisterBloc());
    injector.registerFactory(() => MainBloc());
    injector.registerFactory(() => SearchBloc());
    injector.registerFactory(() => LibraryBloc());
  }
}
