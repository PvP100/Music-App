import 'package:get_it/get_it.dart';
import 'package:music_app/features/data/models/image_model/image_model.dart';

class ModelDi {
  ModelDi._();

  static Future<void> init(GetIt injector) async {
    injector.registerFactory<ImageModel>(() => ImageModel());
  }
}
