import 'package:get_it/get_it.dart';
import 'package:music_app/core/constants/route_constants.dart';

import '../features/presentation/ui/screen/base/base_screen.dart';
import '../features/presentation/ui/screen/screens.dart';

class ScreenDi {
  ScreenDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerFactoryParam<BaseScreen, Map<String, dynamic>?, void>(
      (p1, _) => SplashScreen(),
      instanceName: RouteConstants.splash,
    );
    injector.registerFactoryParam<BaseScreen, Map<String, dynamic>?, void>(
      (p1, _) => HomeScreen(arguments: p1),
      instanceName: RouteConstants.home,
    );
  }
}
