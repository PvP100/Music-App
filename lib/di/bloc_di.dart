import 'package:get_it/get_it.dart';
import 'package:music_app/features/presentation/blocs/blocs.dart';

class BlocDi {
  BlocDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerLazySingleton(() => AppBloc());
    injector.registerFactory(() => SplashBloc(injector()));
    injector.registerFactory(() => HomeBloc(injector()));
    injector.registerFactory(() => LoginBloc(injector(), injector()));
    injector.registerFactory(() => LoginOrRegisterBloc());
    injector.registerFactory(() => ChangePasswordBloc());
    injector.registerFactory(() => ForgotPasswordBloc());
    injector.registerFactory(() => RegisterBloc(injector()));
    injector.registerFactory(() => MainBloc(injector()));
    injector.registerFactory(() => CategoryBloc(injector()));
    injector.registerFactory(() => SearchBloc(injector()));
    injector.registerFactory(() => LibraryBloc());
    injector.registerFactory(() => ProfileBloc(injector()));
    injector.registerFactory(() => SettingBloc(injector(), injector()));
    injector.registerFactory(() => AlbumBloc(injector()));
    injector.registerFactory(() => ArtistBloc(injector()));
  }
}
