import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/core/constants/route_constants.dart';
import '../features/presentation/ui/screen/screens.dart';

class ScreenDi {
  ScreenDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerFactory<Widget>(() => const SplashScreen(),
        instanceName: RouteConstants.splash);
    injector.registerFactory<Widget>(() => const HomeScreen(),
        instanceName: RouteConstants.home);
    injector.registerFactory<Widget>(() => const LoginScreen(),
        instanceName: RouteConstants.login);
    injector.registerFactory<Widget>(() => const LoginOrRegisterScreen(),
        instanceName: RouteConstants.loginOrRegister);
    injector.registerFactory<Widget>(() => const ChangePasswordScreen(),
        instanceName: RouteConstants.changePassword);
    injector.registerFactory<Widget>(() => const ForgotPasswordScreen(),
        instanceName: RouteConstants.forgotPassword);
    injector.registerFactory<Widget>(() => const RegisterScreen(),
        instanceName: RouteConstants.register);
    injector.registerFactory<Widget>(() => const MainScreen(),
        instanceName: RouteConstants.main);
    injector.registerFactory<Widget>(() => const CategoryScreen(),
        instanceName: RouteConstants.category);
    injector.registerFactory<Widget>(() => const SearchScreen(),
        instanceName: RouteConstants.search);
    injector.registerFactory<Widget>(() => const LibraryScreen(),
        instanceName: RouteConstants.library);
    injector.registerFactory<Widget>(() => const ProfileScreen(),
        instanceName: RouteConstants.profile);
    injector.registerFactory<Widget>(() => const SettingScreen(),
        instanceName: RouteConstants.setting);
    injector.registerFactory<Widget>(() => const AlbumScreen(),
        instanceName: RouteConstants.album);
    injector.registerFactory<Widget>(() => const ArtistScreen(),
        instanceName: RouteConstants.artist);
    injector.registerFactory<Widget>(() => const PersonalInformationScreen(),
        instanceName: RouteConstants.personal);
    injector.registerFactory<Widget>(() => const LikeScreen(),
        instanceName: RouteConstants.like);
  }
}
