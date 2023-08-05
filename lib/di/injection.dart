import 'package:get_it/get_it.dart';
import '../config/config.dart';
import 'di.dart';

class AppInjection {
  static final getIt = GetIt.instance;

  static Future<void> configureInjection(BuildMode buildMode) async {
    await ModelDi.init(getIt);
    await ApiDi.init(getIt);
    await NetworkDi.init(getIt, buildMode: buildMode);
    await RepositoryDi.init(getIt);
    await UseCaseDi.init(getIt);
    await BlocDi.init(getIt);
    await ScreenDi.init(getIt);
  }
}
