import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/image_model/image_model.dart';

abstract class ImageRepository {
  Future<Result<ImageModel>> getRandomImage();
}
