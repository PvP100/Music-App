import 'package:music_app/features/data/base/base_dio.dart';
import 'package:music_app/features/data/base/result.dart';
import 'package:music_app/features/data/models/image_model/image_model.dart';

abstract class ImageApiProvider {
  Future<Result<ImageModel>> getRandomImage();
}

class ImageApiProviderImpl implements ImageApiProvider {
  final IBaseDio _baseDio;

  ImageApiProviderImpl(this._baseDio);

  @override
  Future<Result<ImageModel>> getRandomImage() =>
      _baseDio.request('photos/random');
}
